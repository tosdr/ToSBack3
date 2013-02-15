class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email].downcase)
    if user && user.authenticate(params[:password])
      # Sign the user in and redirect to the user's show page.
    else
      flash.now[:error] = "Sorry, the email and password combination was invalid."
      render :new
    end
  end

  def destroy
  end
end
