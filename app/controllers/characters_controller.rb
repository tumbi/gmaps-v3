class CharactersController < ApplicationController
  require 'will_paginate/array'
  require 'csv'
  # GET /characters
  # GET /characters.json
  before_filter :authenticate_user!, :except => [:show, :index]
  
  def send_contract
    @character = current_user.characters.find(params[:id])
    CharacterExpiry.contract_email(@character,current_user).deliver

    respond_to do |format|
      format.html { redirect_to characters_url, notice: 'Email was successfully sent'  }
      format.json { head :no_content }
    end
  end

  def send_sms
    @character = current_user.characters.find(params[:id])
    api = Clickatell::API.authenticate('3415596', 'sbsfence','sbsfence123')
    api.send_message(@character.mobile_number, "Your Rental Contract is expiring soon")
    respond_to do |format|
      format.html { redirect_to characters_url, notice: 'SMS was successfully sent'  }
      format.json { head :no_content }
    end
  rescue Clickatell::API::Error => e
    respond_to do |format|
      format.html { redirect_to characters_url, error: "Clickatell API error: #{e.message}" }
      format.json { head :no_content }
    end
  end

  def index
    if user_signed_in?
      if (params[:search])
        if(params[:search] == "all" || params[:search] == "")
          @characters = current_user.characters.find(:all, :order => :contractendon)
        else
          @search = current_user.characters.search do
            fulltext params[:search]
          end
          @characters = @search.results
          
          @characters = @characters.paginate(:page => params[:page], :per_page => 2)
        end
      else
        @characters = current_user.characters.find(:all, :order => :contractendon)
        
        @characters = @characters.paginate(:page => params[:page], :per_page => 2)
      end
      @json = current_user.characters.all.to_gmaps4rails
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @characters }
      end
    else
      redirect_to new_user_session_path
    end
  end

  # GET /characters/1
  # GET /characters/1.json
  def show
    @character = current_user.characters.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @character }
    end
  end

  # GET /characters/new
  # GET /characters/new.json
  def new
    @character = current_user.characters.new
    @assets = Asset.where(:company_id => current_user.company_id)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @character }
    end
  end

  # GET /characters/1/edit
  def edit
    @assets = Asset.where(:company_id => current_user.company_id)
    @character = current_user.characters.find(params[:id])
  end

  # POST /characters
  # POST /characters.json
  def create
   
    @character = current_user.characters.new(params[:character])
    @assets = Asset.where(:company_id => current_user.company_id)
    respond_to do |format|
      format.html do
        if @character.save!
          unless params[:assets].blank?
            params[:assets].each do|a|
              asset = Asset.find_by_name(a)
              @character.assets << asset
            end
          end
          redirect_to characters_path, notice: 'Character was successfully created.'
        else
          render action: "new"
        end
      end
      format.js do
        if @character.save
          format.json { render json: @character, status: :created, location: @character }
        else
          format.json { render json: @character.errors, status: :unprocessable_entity }
        end

      end
    end
  end

  # PUT /characters/1
  # PUT /characters/1.json
  def update
    @character = current_user.characters.find(params[:id])
    @assets = Asset.where(:company_id => current_user.company_id)
    #    respond_to do |format|
    if @character.update_attributes(params[:character])
      #        solr.update(:character)
      redirect_to @character, notice: 'Character was successfully updated.'
      #        format.json { head :no_content }
    else
      render action: "edit"
      #        format.json { render json: @character.errors, status: :unprocessable_entity }
    end
    #    end
  end

  # DELETE /characters/1
  # DELETE /characters/1.json
  def destroy
    @character = current_user.characters.find(params[:id])
    @character.destroy

    respond_to do |format|
      format.html { redirect_to characters_url }
      format.json { head :no_content }
    end
  end

  def view_full_map
    @json = current_user.characters.all.to_gmaps4rails
    
  end

  def set_position
    @character = Character.find(params[:id])
    @json = current_user.characters.all.to_gmaps4rails
    #    respond_to do |format|
    #      format.js do
    #        foo =  render_to_string(:partial => "map_partial", :locals => {:json => @json, :lat => @character.latitude, :long => @character.longitude}).to_json
    #        render :js => "$('#map_div').html(#{foo})"
    #      end
    #    end
  end

  def export_to_csv
    @characters = current_user.characters
    csv_string = CSV.generate do |csv|
      csv << ["contract number", "name", "address", "contract ends on", "fences", "latitude", "longitude", "gmaps"]
      @characters.each_with_index do |chr|
        csv << [chr.contract_number,chr.name, chr.address, chr.contractendon, chr.fences, chr.latitude,chr.longitude, chr.gmaps]
      end
    end
    send_data csv_string, :filename => "output.csv" , :type=>"text/csv"
  end

  def import_records
    data_file = params[:data_file].read
    CSV.parse(data_file).each_with_index do |row,i|
      if i > 0
        @check_character = Character.find_by_contract_number(row[0])
        if @check_character.blank?
          @new_character = Character.new(:contract_number => row[0],:name => row[1],
            :address => row[2],:contractendon => row[3],:fences => row[4],
            :latitude => row[5],:longitude => row[6], :gmaps => row[7])
          @new_character.save
        else
          @check_character.name = row[1]
          @check_character.address = row[2]
          @check_character.contractendon = row[3]
          @check_character.fences = row[4]
          @check_character.latitude = row[5]
          @check_character.longitude = row[6]
          @check_character.gmaps = row[7]
          @check_character.save
        end
      end
    end
    redirect_to characters_path
  end

  def reminder_email
    Character.send_reminder_email
    redirect_to :back
  end
end