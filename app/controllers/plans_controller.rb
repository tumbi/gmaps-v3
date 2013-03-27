class PlansController < ApplicationController
  def index
    @plans = Plan.all
    if @plans.blank?
      redirect_to "/"
    end
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(params[:plan])
    @plan.save
    redirect_to plans_path
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def update
    @plan = Plan.find(params[:id])
    @plan.update_attributes(params[:plan])
    @plan.save
    redirect_to plans_path
  end

  def destroy
    @plan = Plan.find(params[:id])
    @plan.destroy
    redirect_to plans_path
  end

end