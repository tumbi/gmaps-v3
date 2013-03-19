class RegistrationsController < Devise::RegistrationsController

  def new
    super
  end

  def create
    @user = User.new(params[:user])
    @user.save
    if params[:user][:company_id]
      @user.company_id = params[:user][:company_id]
    else
      @company = Company.new(:company_name => params[:company_name], :subdomain => params[:subdomain])
      @company.save
      @user.company_id = @company.id
    end
    @user.save
    super
  end
  
 
end
