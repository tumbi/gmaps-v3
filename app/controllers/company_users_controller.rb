class CompanyUsersController < ApplicationController

  def index
    @company_users = current_user.company.users
  end

  def new
    @user = User.new
  end

  def create

    @user = User.new(params[:user])
    @user.skip_confirmation!
    
    if @user.save
      role = add_role(params[:account_type])
      @user.roles << role
      CharacterExpiry.send_user_information(@user).deliver
      redirect_to company_users_path
    else
      render :new
    end
  end

end
