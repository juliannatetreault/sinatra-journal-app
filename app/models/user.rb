class User < ActiveRecord::Base 
has_many :journal_entry
has_secure_password

validates :username, :email, presence: true
end