class CreateNotificationSettings < ActiveRecord::Migration
  def change
    create_table :notification_settings do |t|
      t.boolean :monthly_reminder
      t.boolean :bimonthly_reminder
      t.boolean :weekly_reminder
      t.boolean :oneday_reminder
      t.integer :user_id

      t.timestamps
    end
  end
end
