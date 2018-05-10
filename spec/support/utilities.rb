def sign_in(user)
  visit new_user_session_path
  fill_in "user_email",    with: user.email.upcase
  fill_in "user_password", with: user.password
  click_button "Log in"
end
