class UserPlans < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :asset
  belongs_to :character
end
