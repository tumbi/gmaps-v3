class ApplicationController < ActionController::Base
  protect_from_forgery
  private
  def after_sign_out_path_for(resource_name)
new_user_session_path
end

end
