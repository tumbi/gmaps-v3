class UsersController < Devise::RegistrationsController

  before_filter :check_permissions, :only => [:new, :create, :cancel]
  skip_before_filter :require_no_authentication

  def check_permissions
    authorize! :create, resource
  end

  def update_user
    user = User.find(params[:u])
    unless user.blank?
      @company = Company.new(:company_name => params[:company_name], :subdomain => params[:subdomain])
      @company.save!
      user.update_attributes({"company_id" => @company.id, "country" => params[:user][:country], "timezone" => params[:user][:timezone]})
      flash[:notice] = "User company details added successfully!"
    else
      flash[:notice] = "User details not found plaese try again or later!"
    end
    redirect_to "/"
  end

end