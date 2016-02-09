require 'rails_helper'

RSpec.describe User, :type => :model do
  it 'knows its role in society' do
    user = User.create
    user.roles.create role: :admin # Make the user an admin.
    expect(user).to be_admin # RSpec for "assert that user.admin? is true"
  end
end
