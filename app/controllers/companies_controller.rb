class CompaniesController < ApplicationController
  layout "application"

  def new
    if current_user.blank?
      if params[:u].blank?
        redirect_to root_path
      else
        @user = User.find(params[:u])
      end
    else
      @user = current_user
      unless current_user.company_id.blank?
        redirect_to "/"
      end
    end
  end

  def show
    @company = Company.find_by_id(params[:id])
  end

  def update
    @company = Company.find_by_id(params[:id])
    @company.update_attributes(params[:company])
    redirect_to company_path(@company)
  end
end