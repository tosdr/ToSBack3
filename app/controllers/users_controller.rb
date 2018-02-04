class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to TOSBack!"
      helpers.sign_in @user
      redirect_to user_path(@user)
    else
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Successfully saved!"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end
end

private

def signed_in_user
  redirect_to signin_path, notice: "Please sign in." unless helpers.signed_in?
end

def correct_user
  redirect_to root_path unless helpers.current_user == User.find(params[:id])
end
