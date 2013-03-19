class User < ActiveRecord::Base
	has_many :characters
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,:confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :mobile_number, :country, :timezone,:company_id
  # attr_accessible :title, :body
  belongs_to :company

 

end
