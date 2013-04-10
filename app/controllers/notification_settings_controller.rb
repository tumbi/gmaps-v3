class NotificationSettingsController < ApplicationController
  
  def index
    @notification_setting = current_user.notification_setting
  end

  def new
    @notification_setting = NotificationSetting.new
  end

  def create
    @notification_setting = NotificationSetting.new(params[:notification_setting])
    @notification_setting.save
    redirect_to notification_settings_path
  end

  def update
    @notification_setting = NotificationSetting.find(params[:id])
    @notification_setting.update_attributes(params[:notification_setting])
    redirect_to notification_settings_path
  end

end