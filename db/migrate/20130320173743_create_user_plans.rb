class CreateUserPlans < ActiveRecord::Migration
  def change
    create_table :user_plans do |t|

      t.timestamps
    end
  end
end
