class Admin::UsersController < ApplicationController
  layout "admin"
  
  def index
    @users = User.all
  end

  def new_company
    @user = User.new
  end

  def new_company_user
    @user = User.new
  end

  def create_company
    @user = User.new(params[:user])
    @user.skip_confirmation!
    @company = Company.new(:company_name => params[:company_name], :subdomain => params[:subdomain])
    @company.save
    @user.company_id = @company.id
    if @user.save
      role = add_role("company")
      @user.roles << role
#      UserMailer.send_user_information(@user).deliver
      redirect_to admin_users_path
    else
      render :new_company
    end
  end

  def create_company_user
    @user = User.new(params[:user])
    @user.skip_confirmation!    
#    @user.company_id = @company.id
    if @user.save
      role = add_role(params[:account_type].to_s)
      @user.roles << role
#      UserMailer.send_user_information(@user).deliver
      redirect_to admin_users_path
    else
      render :new_company_user
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    params[:user][:verify_email] = params[:user][:email]
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if @user.update_attributes(params[:user])
      flash[:notice] = "User updated successfully!"
      redirect_to admin_users_path
    else
      flash[:error] = "User can't be updated. Please try again or later!"
      render :edit
    end
  end
end