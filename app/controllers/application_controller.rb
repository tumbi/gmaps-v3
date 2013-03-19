class ApplicationController < ActionController::Base
  include UrlHelper
  protect_from_forgery
  private
  def after_sign_out_path_for(resource_name)
    company = Company.find(current_user.company_id)
    new_user_session_path(:subdomain => company.subdomain)
  end

  def after_sign_in_path_for(resource)
    plans_path
  end
 


end
