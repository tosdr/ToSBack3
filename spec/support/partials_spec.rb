shared_examples "signed in header links" do
  it { should have_link('Sign out', href: signout_path) }
  it { should_not have_link('Sign in', href: signin_path) }
end

shared_examples "signed out header links" do
  it { should_not have_link('Sign out', href: signout_path) }
  it { should have_link('Sign in', href: signin_path) }
end