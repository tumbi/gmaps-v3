class User < ActiveRecord::Base
	has_many :characters
	has_one :notification_setting
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,:confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :mobile_number, :country, :timezone,:company_id, :is_active
  # attr_accessible :title, :body
  belongs_to :company

  has_and_belongs_to_many :roles
end
