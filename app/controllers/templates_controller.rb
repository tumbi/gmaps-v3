class TemplatesController < ApplicationController

  def index
    @templates = MessageTemplate.where(:company_id => current_user.company_id)
  end

  def new
    @template = MessageTemplate.new
  end

  def create    
    unless params[:message_template][:body].blank?
      params[:message_template][:body] = set_template(params)
    end
    
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

    unless params[:message_template][:body].blank?
      params[:message_template][:body] = set_template(params)
    end

    @template.update_attributes(params[:message_template])
    @template.save
    redirect_to templates_path
  end

  def destroy
    @template = MessageTemplate.find(params[:id])
    @template.destroy
    redirect_to templates_path
  end

  private
  def set_template(params)
    params[:message_template][:body] = params[:message_template][:body].gsub('<input type="button"',"")
    params[:message_template][:body] = params[:message_template][:body].gsub('value="address" />','#{@character.address}')
    params[:message_template][:body] = params[:message_template][:body].gsub('value="name" />','#{@character.name}')
    params[:message_template][:body] = '"'+params[:message_template][:body].strip+'"'
  end

end