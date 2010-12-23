require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "fields must not be blank" do
    user = User.new    
    assert !user.valid?
    assert user.errors[:name].any?
    assert user.errors[:email].any?
    assert user.errors[:password].any?
    assert user.errors[:password_confirmation].any?
    assert user.errors[:role].any?
  end

  test "email format must be valid" do
    user = User.new( :role => 0,
                     :password => 'password',
                     :password_confirmation => 'password')
    user.email = 'user'
    assert !user.valid?

    user.email = 'user@aaa'
    assert !user.valid?

    user.email = 'user@example.com'
    assert_equal 0, user.role
    user.valid?
  end

  test "password and confirmation must match" do
    user = User.new( :role => 1,
                     :email => 'user@example.com',
                     :name => 'any name')
    user.password = 'password'
    user.password_confirmation = 'pswd'
    assert !user.valid?

    user.password_confirmation = 'password'
    assert user.valid?
  end

  test "email must be unique" do
    user = User.new(:name => 'any name', :password => 'p', :password_confirmation => 'p', :email => users(:user_one).email)
    assert !user.valid?
  end

  test "authentication should be ok" do
    assert User.authenticate(users(:user_one).email, 'passone')
  end
end
