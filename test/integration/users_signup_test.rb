require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "invalid signup information"do
    get signup_path
    # assert_no_differenceはブロック
    # ブロックを実行する前後で引数の値(User.count)が変わらないかをチェックしている
    assert_no_difference 'User.count' do
      # users_pathに対してpostメソッドを送信している
      post users_path, params: { user: { name: "",
                                          email: "user@invalid",
                                          password: "foo",
                                          password_confirmation: "bar"}}
    end

    assert_template 'users/new'
    assert_select 'form[action="/signup"]'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
  end

  
  test "valid signup information" do
    get signup_path
    # assert_differenceブロック内の処理を実行する直前と、実行した直後のUser.countの値を比較し、1増えた際にtrue
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    assert is_logged_in?
  end
end