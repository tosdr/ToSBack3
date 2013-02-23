def sign_in(user)
  visit signin_path
  fill_in "login_email",    with: user.email.upcase
  fill_in "login_password", with: user.password
  click_button "Sign in"
  # not using capybara
end
