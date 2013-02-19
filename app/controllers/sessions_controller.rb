class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email].downcase)
    if user && user.authenticate(params[:password])
      sign_in user
      redirect_to user_path(user), notice: "Successfully signed in!"
    else
      flash.now[:error] = "Sorry, the email and password combination was invalid."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You have successfully signed out!"
  end
end
