class Asset < ActiveRecord::Base
  attr_accessible :name, :description, :model, :quantity
  belongs_to :comapny
end
