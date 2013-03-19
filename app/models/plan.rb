class Plan < ActiveRecord::Base
  attr_accessible :title, :description, :frequency, :price
end
