class PlanUsers < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :plan
  belongs_to :user
end
