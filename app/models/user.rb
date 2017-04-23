class User < ActiveRecord::Base
  attr_accessor :login
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :encryptable

	validates :username,
		:presence => true,
		:uniqueness => {
			:case_sensitive => false
		} # etc.
   

  def password_salt
    'no salt'
  end

  def password_salt=(new_salt)
  end

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

	def self.find_for_database_authentication(warden_conditions)
		conditions = warden_conditions.dup
		if login = conditions.delete(:login)
			where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
		else
			where(conditions.to_h).first
		end
	end
end
