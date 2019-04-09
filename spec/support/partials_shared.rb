RSpec.shared_examples "it has signed in header links" do
  it { should have_link('Sign out', href: destroy_user_session_path) }
  xit { should have_link('Subscriptions', href: user_path(user_id)) }
  it { should have_link('Account', href: edit_user_registration_path) }
  it { should_not have_link('Sign in', href: new_user_session_path) }
end

RSpec.shared_examples "it has signed out header links" do
  it { should_not have_link('Sign out', href: destroy_user_session_path) }
  it { should have_link('Sign in', href: new_user_session_path) }
end
