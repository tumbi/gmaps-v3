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
      root_path(:subdomain => company.subdomain)
    else
      root_path(:subdomain => "")
    end
  end

  def after_sign_in_path_for(resource)
    unless is_admin?
      company = Company.find(current_user.company_id) if !current_user.company_id .blank?
      unless company.blank?
        plans = current_user.plans
        #        plans = current_user.plans.where("is_active = true")
        day_diff = (Date.today - current_user.confirmed_at.to_date).to_i

        if plans.blank?
          if day_diff > 30
            flash[:notice] = "Free trial period is over please select a plan."
            choose_plan_plans_path(:user => current_user.id, :subdomain => "")
          else
            root_path(:subdomain => company.subdomain)
            #            redirect_to choose_plan_plans_path(:user => @user.id, :subdomain => "")
          end
        else
          #          Will check the selected plans here
          root_path(:subdomain => company.subdomain)
        end
      else
        new_company_path
      end
    else
      admin_users_path#      
    end
  end
end