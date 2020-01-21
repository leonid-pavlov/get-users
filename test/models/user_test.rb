require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should not save user without role" do
    user = User.new(email: 'test@example.org')
    assert_not user.save
  end

  test "should not save user without email" do
    user = User.new(role: :admin)
    assert_not user.save
  end

  test "should save user with valid data" do
    user = User.new(email: 'test@example.org', role: :admin)
    assert user.save
  end
  
  test "should not save user with duplicating email" do
    User.create(email: 'test@example.org', role: :admin)
    user = User.new(email: 'test@example.org', role: :moderator)
    assert_not user.save
  end
  
end
