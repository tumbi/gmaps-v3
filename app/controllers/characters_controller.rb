class CharactersController < ApplicationController

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


  def index
    if user_signed_in?
    @characters = current_user.characters.find(:all, :order => :contractendon)
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

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @character }
    end
  end

  # GET /characters/1/edit
  def edit
    @character = current_user.characters.find(params[:id])
  end

  # POST /characters
  # POST /characters.json
  def create
    @character = current_user.characters.new(params[:character])

    respond_to do |format|
      if @character.save
        format.html { redirect_to @character, notice: 'Character was successfully created.' }
        format.json { render json: @character, status: :created, location: @character }
      else
        format.html { render action: "new" }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /characters/1
  # PUT /characters/1.json
  def update
    @character = current_user.characters.find(params[:id])

    respond_to do |format|
      if @character.update_attributes(params[:character])
        format.html { redirect_to @character, notice: 'Character was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
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
end
