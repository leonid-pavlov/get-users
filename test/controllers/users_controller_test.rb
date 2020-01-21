require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should return bad_request for access without xhr" do
    get user_url users(:one)
    assert_response :bad_request
  end  
  
  test "should get user as json" do
    get user_url(users(:one)), xhr: true

    assert_response :success 
    assert_equal 'application/json', @response.media_type

    response_user = JSON.parse(@response.body)
    assert_equal 'admin@example.org', response_user['email']
  end
    
  test "should include advertiser_info for advertiser user" do
    get user_url(users(:four)), xhr: true
    assert_response :success 
    
    response_user = JSON.parse(@response.body)

    assert_equal 'advertiser', response_user['role']
    assert_not_nil response_user['advertiser_info']
  end

  test "should not include advertiser_info for non advertiser user" do  
    get user_url(users(:one)), xhr: true
    assert_response :success 
    
    response_user = JSON.parse(@response.body)

    assert_equal 'admin', response_user['role']
    assert_nil response_user['advertiser_info']
  end
  
  test "should create user and return it as json" do
    assert_difference('User.count') do
      post users_url, params: { user: { email: 'executor2@example.org', role: 'executor' } }, xhr: true
      assert_response :success 

      response_user = JSON.parse(@response.body)
      assert_equal 'executor2@example.org', response_user['email']
      assert_equal 'executor', response_user['role']
    end
  end
  
  test "should advertiser user with nested attributes" do
    assert_difference('User.count') do
      post users_url, params: { user: { 
        email: 'advertiser2@example.org', 
        role: 'advertiser', 
        advertiser_info_attributes: {
          organisation: 'organisation one',
          position: 'position one'
        } 
      }}, xhr: true
      assert_response :success 

      response_user = JSON.parse(@response.body)
      assert_not_nil response_user['advertiser_info']
      assert_equal 'organisation one', response_user['advertiser_info']['organisation']
      assert_equal 'position one', response_user['advertiser_info']['position']
    end
  end
  
  test "should include validation errors for creating invalid user" do
    post users_url, params: { user: { email: nil } }, xhr: true

    assert_response :unprocessable_entity
    assert_equal 'application/json', @response.media_type
    assert_not_nil @response.body
  end
 
  test "should update user" do
    patch user_url(users(:one)), params: { user: { name: 'updated name' } }, xhr: true

    assert_response :success 
    assert_equal 'application/json', @response.media_type

    response_user = JSON.parse(@response.body)
    assert_equal 'updated name', response_user['name']
  end  

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(User.last), xhr: true
      assert_response :success 
    end
  end

end
