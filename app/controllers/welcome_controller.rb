class WelcomeController < ApplicationController

  def index
    unless current_user.blank?
      if is_admin?
        redirect_to admin_users_path
      end
    end
  end

end
