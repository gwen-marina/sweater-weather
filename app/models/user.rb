class User < ApplicationRecord
  validates_uniqueness_of :email
  validates_presence_of :email
  validates_uniqueness_of :api_key
  validates_presence_of :api_key

  has_secure_password
end
