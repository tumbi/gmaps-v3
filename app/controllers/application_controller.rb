class ApplicationController < ActionController::Base
  include UrlHelper
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  def add_role(role)
    Role.find_by_name(role)
  end

  def is_admin?
    admin = Role.find_by_name("admin")
    current_user.roles.include?(admin)
  end

  private
  def after_sign_out_path_for(resource_name)
    unless current_user.company_id.blank?
      company = Company.find(current_user.company_id)
      new_user_session_path(:subdomain => company.subdomain)
    else
      new_user_session_path(:subdomain => "")
    end
  end

  def after_sign_in_path_for(resource)
    unless is_admin?
      flash[:error] = t(:authorized)
      plans_path
    else
      admin_users_path
    end
  end

end