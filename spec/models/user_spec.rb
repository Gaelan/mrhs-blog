require 'rails_helper'

RSpec.describe User, type: :model do
  it 'knows its role in society' do
    user = User.create! given_name: 'Dennis', family_name: 'Ritchie', email: 'dmr@research.att.com'
    user.roles.create role: :admin # Make the user an admin.
    expect(user).to be_admin # RSpec for "assert that user.admin? is true"
  end

  it 'can be called by name' do
    user = User.new given_name: 'Alan', family_name: 'Turing'
    expect(user.name).to eq 'Alan Turing'

    user = User.new given_name: '', family_name: 'Fureigh'
    expect(user.name).to eq 'Fureigh'

    user = User.new given_name: 'John', family_name: 'Hall', preferred_name: 'Mad Dog'
    expect(user.name).to eq 'Mad Dog Hall'
  end
end
