class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email].downcase)
    if user && user.authenticate(params[:password])
      sign_in user
      flash[:success] = "Successfully signed in!"
      redirect_to user_path(user)
    else
      flash.now[:error] = "Sorry, the email and password combination was invalid."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have successfully signed out!"
    redirect_to root_path
  end
end
