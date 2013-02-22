class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to TOSBack!"
      sign_in @user
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