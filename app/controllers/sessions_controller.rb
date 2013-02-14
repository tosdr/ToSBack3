class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    render :new
  end

  def destroy
  end
end
