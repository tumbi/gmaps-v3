class AddFieldsToUserPlans < ActiveRecord::Migration
  def change
     add_column :plan_users, :plan_id, :integer
     add_column :plan_users, :user_id, :integer
     add_column :plan_users, :is_active, :boolean
  end
end