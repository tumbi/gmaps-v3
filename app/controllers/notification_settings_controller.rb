class NotificationSettingsController < ApplicationController
  
  def new
    @notification_setting = NotificationSetting.new
  end

  def create
    @notification_setting = NotificationSetting.new(params[:notification_setting])
    @notification_setting.save
    redirect_to "/"
  end

end