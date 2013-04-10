class Company < ActiveRecord::Base
  attr_accessible :company_name, :subdomain, :address, :company_type, :phone_number, :fax_number
  has_many :users
  has_many :assets

  validates :subdomain, :presence => true
  validates_format_of :subdomain, with: /^[a-z0-9_]+$/, message: "must be lowercase alphanumerics only"
  validates_length_of :subdomain, maximum: 32, message: "exceeds maximum of 32 characters"
  validates_exclusion_of :subdomain, in: ['www', 'mail', 'ftp'], message: "is not available"

  has_many :message_templates
end
