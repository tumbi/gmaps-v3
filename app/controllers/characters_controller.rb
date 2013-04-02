class CharactersController < ApplicationController
  require 'will_paginate/array'
  require 'csv'
  # GET /characters
  # GET /characters.json
  before_filter :authenticate_user!, :except => [:show, :index]
  
  def send_contract
    @character = current_user.characters.find(params[:id])
    CharacterExpiry.contract_email(@character,current_user,current_user.company.message_templates.last).deliver

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
      #      @json = @characters.to_gmaps4rails
      @json = current_user.characters.all.to_gmaps4rails
      
      respond_to do |format|
        format.html
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
    @json = @character.to_gmaps4rails
  end

  def export_to_csv
    @characters = current_user.characters
    csv_string = CSV.generate do |csv|
      csv << ["contract number", "name", "address", "contract ends on", "location", "gmaps","email","mobile number"]
      @characters.each_with_index do |chr|
        addr = ""
        if !chr.latitude.blank? and !chr.longitude.blank?
          addr = chr.latitude.to_s+","+chr.longitude.to_s
        end
        unless addr.blank?
          location = Geocoder.search(addr) if !addr.blank?
          unless location.blank?
            addr = location[0].address
          end
        end
        csv << [chr.contract_number,chr.name, chr.address, chr.contractendon, addr, chr.gmaps,chr.email,chr.mobile_number]
      end
    end
    send_data csv_string, :filename => "output.csv" , :type=>"text/csv"
  end

  def import_records
    data_file = params[:data_file].read
    CSV.parse(data_file).each_with_index do |row,i|
      if i > 0
        @check_character = Character.find_by_contract_number(row[0])
        #        Get the latitude and longitude from the location
        lat = ""
        long = ""
        unless row[4].blank?
          a = Geocoder.search(row[4])
          unless a.blank?
            lat = a[0].latitude
            long = a[0].longitude
          end
        end

        if @check_character.blank?
          @new_character = Character.new(:contract_number => row[0],:name => row[1],
            :address => row[2], :contractendon => row[3],
            :latitude => lat,:longitude => long, :gmaps => row[5], :email => row[6],
            :mobile_number => row[7], :user_id => current_user.id)
          @new_character.save
        else
          @check_character.name = row[1]
          @check_character.address = row[2]
          @check_character.contractendon = row[3]
          @check_character.latitude = lat
          @check_character.longitude = long
          @check_character.gmaps = row[5]
          @check_character.email = row[6]
          @check_character.mobile_number = row[7]
          @check_character.user_id = current_user.id
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