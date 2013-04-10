class CompaniesController < ApplicationController
  layout "application"
  def show
    @company = Company.find_by_id(params[:id])
  end

  def update
    @company = Company.find_by_id(params[:id])
    @company.update_attributes(params[:company])
    redirect_to company_path(@company)
  end
end