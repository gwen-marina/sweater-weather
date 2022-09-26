class User < ApplicationRecord

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :password_digest
 
  has_secure_password

  def generate_api_key 
    self.api_key = [*('a'..'z'),*('0'..'9')].shuffle[0,31].join
  end
end
