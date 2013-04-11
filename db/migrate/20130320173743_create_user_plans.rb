class CreateUserPlans < ActiveRecord::Migration
  def change
    create_table :plan_users do |t|

      t.timestamps
    end
  end
end
