require 'rails_helper'

RSpec.describe User, type: :model do
  it 'knows what is right and wrong' do
    user = User.new
    expect(user).not_to be_valid
  end

  it 'knows its role in society' do
    user = User.create! given_name: 'Dennis', family_name: 'Ritchie', email: 'dmr@bell-labs.com'
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

  describe 'validations' do
    it 'fail with duplicate e-mail address' do
      user1 = User.create given_name: 'Here', family_name: 'First', email: 'hf@example.com'
      user2 = User.new given_name: 'Dopple', family_name: 'Ganger', email: 'hf@example.com'
      expect(user2).not_to be_valid
    end

    it 'succeed with a unique e-mail address' do
      user1 = User.create given_name: 'Here', family_name: 'First', email: 'hf@example.com'
      user2 = User.new given_name: 'Dopple', family_name: 'Ganger', email: 'dg@example.com'
      expect(user2).to be_valid
    end
  end
end
