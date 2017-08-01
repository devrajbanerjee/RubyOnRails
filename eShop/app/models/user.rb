class User < ApplicationRecord
	#Fields
	attr_accessor :password
	
	#Validations
	validates :name, :email, presence: true
	validates :email, uniqueness: true
	validates :email, format: {with: /\A.+\..+@example\.com\z/}
	validates :password, presence: true, on: :create
	
	#Callbacks
	before_save :encrypt_password, if: -> {self.password.present?}
	
	# Class Methods
	def self.authenticate(email, password)
		if email.present? && password.present?
			if user = User.find_by(email: email)
				if user.valid_password?(password)
					user
				end
			end
		end		
	end
	
	#Methods
	def valid_password?(password)
		self.encrypted_password == Digest::MDS.hexdigest(password)
	end
	
	def encrypt_password
		self.encrypted_password = Digest::MDS.hexdigest(password)
	end
	
end
