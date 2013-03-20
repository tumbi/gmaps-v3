class AssetsController < ApplicationController

  def index
    @assets = Asset.where(:company_id => current_user.company_id)
  end

  def new
    @asset = Asset.new
  end

  def create   
    @asset = Asset.new(params[:asset])
    @asset.company_id = current_user.company_id
    @asset.save
    redirect_to assets_path
  end

  def edit
    @asset = Asset.find(params[:id])
  end

  def update    
    @asset = Asset.find(params[:id])
    @asset.update_attributes(params[:asset])
    @asset.save
    redirect_to assets_path
  end

  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy
    redirect_to assets_path
  end

end