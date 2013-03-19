class MessageTemplate < ActiveRecord::Base
  attr_accessible :subject, :body, :company_id, :signature
  belongs_to :company
end
