class NotificationSetting < ActiveRecord::Base
  attr_accessible :oneday_reminder, :user_id, :weekly_reminder, :bimonthly_reminder, :monthly_reminder
  belongs_to :user
end
