class RegistrationsController < Devise::RegistrationsController

  def new
    super
  end

  def create
    @user = User.new(params[:user])
    if !params[:user][:company_id].blank?
      @user.company_id = params[:user][:company_id]
      if @user.save
        role = add_role(params[:account_type].to_s)
        @user.roles << role
      end
    else
      @company = Company.new(:company_name => params[:company_name], :subdomain => params[:subdomain])
      @company.save
      @user.company_id = @company.id
      if @user.save
        role = add_role("company")
        @user.roles << role
      end
    end
    redirect_to "/"
  end
  
end