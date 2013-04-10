class Plan < ActiveRecord::Base
  attr_accessible :title, :description, :frequency, :price, :plan_type
  belongs_to :company
end
