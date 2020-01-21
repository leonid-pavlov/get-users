require 'test_helper'

class AdvertiserInfosTest < ActiveSupport::TestCase
  test "should not save advertiser_info without user" do
    info = AdvertiserInfo.new
    assert_not info.save
  end
  
  test "should present advertiser_info for valid advertiser user" do
    user = User.create(email: 'test@example.org', role: :advertiser)
    assert_not_nil user.advertiser_info
  end
  
  test "should not present advertiser_info for valid non-advertiser user" do
    user = User.create(email: 'test@example.org', role: :admin)
    assert_nil user.advertiser_info
  end

  test "should not present advertiser_info after user role changed" do
    user = User.create(email: 'test@example.org', role: :advertiser)
    user.role = :admin
    user.save
    user.reload
    assert_nil user.advertiser_info
  end 

end
