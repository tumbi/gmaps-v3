class Plan < ActiveRecord::Base
  attr_accessible :title, :description, :frequency, :price, :plan_type
  belongs_to :company
  belongs_to :user
  has_and_belongs_to_many :fee_plans, :class_name => 'User', :join_table => 'plan_users', :association_foreign_key => 'user_id'
end
