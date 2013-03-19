class TemplatesController < ApplicationController

  def index
    @templates = MessageTemplate.where(:company_id => current_user.company_id)
  end

  def new
    @template = MessageTemplate.new
  end

  def create
    
    @template = MessageTemplate.new(params[:message_template])
    @template.company_id = current_user.company_id
    @template.save
    redirect_to templates_path
  end

  def edit
    @template = MessageTemplate.find(params[:id])
  end

  def update
    
    @template = MessageTemplate.find(params[:id])

    @template.update_attributes(params[:message_template])
    @template.save
    redirect_to templates_path
  end

  def destroy
    @template = MessageTemplate.find(params[:id])
    @template.destroy
    redirect_to templates_path
  end
end
