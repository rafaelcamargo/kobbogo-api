require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should be invalid if no username has been provided' do
    user = build(:user, username: '', password: '123')
    expect(user).not_to be_valid
    expect(user.errors.full_messages).to include("Username can't be blank")
  end

  it 'should be invalid if given username has already been taken' do
    create(:user, username: 'John', password: '123')
    user = build(:user, username: 'John', password: '123')
    expect(user).not_to be_valid
    expect(user.errors.full_messages).to include('Username has already been taken')
  end

  it 'should be invalid if no password has been provided' do
    user = build(:user, username: 'Rafael', password: '')
    expect(user).not_to be_valid
    expect(user.errors.full_messages).to include("Password can't be blank")
  end

  it 'should be valid if username and password has been provided' do
    user = build(:user, username: 'Rafael', password: '123')
    expect(user).to be_valid
  end
end
