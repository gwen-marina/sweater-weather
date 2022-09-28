require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password_digest }
    it { should have_secure_password }
  end
 
  it 'can generate a random api key associated with a user when a user is created' do 
      smudger = User.create!(email: 'imadog@dogmail.com', password: 'steak', password_confirmation:'steak')
      smudger.generate_api_key
      expect(smudger.generate_api_key).to be_a(String)
  end
end