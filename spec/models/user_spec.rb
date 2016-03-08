require 'rails_helper'

RSpec.describe User, type: :model do
  it 'knows what is right and wrong' do
    user = User.new
    expect(user).not_to be_valid
  end

  it 'knows its role in society' do
    user = Fabricate(:user)
    user.roles.create role: :admin # Make the user an admin.
    expect(user).to be_admin # RSpec for "assert that user.admin? is true"
  end

  describe '#name' do
    it 'handles normal first/last names' do
      user = User.new given_name: 'Alan', family_name: 'Turing'
      expect(user.name).to eq 'Alan Turing'
    end
    it 'handles people with single names' do
      user = User.new given_name: '', family_name: 'Fureigh'
      expect(user.name).to eq 'Fureigh'
    end
    it 'handles people with preferred names' do
      user = User.new given_name: 'John', family_name: 'Hall', preferred_name: 'Mad Dog'
      expect(user.name).to eq 'Mad Dog Hall'
    end
  end
end
