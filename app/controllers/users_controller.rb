class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      sign_in(@user)
      redirect_to root_path, notice: "You are now signed up!"
    else
      flash[:alert] = "Sign up unsuccessful."
      render :new
    end
  end

  def show
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    if current_user && @user.authenticate(user_params[:current_password]) && user_params[:current_password] != user_params[:password] # checking the current password and making sure it does noe equal the old one.
        user_params.delete(:current_password)
        @user.update user_params
        redirect_to root_path, notice: "Account updated!"
      else
        flash[:alert] = "Unable to update account."
        render :edit
      end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end


end
