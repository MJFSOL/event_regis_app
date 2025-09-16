class AuthController < ApplicationController
  def signin
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      if @user.role == "admin"
        redirect_to admin_dashboard_page_path, notice: "Welcome, Admin!"
      else
        redirect_to user_dashboard_page_path, notice: "Welcome back" + @user.email
      end
    else
      flash.now[:alert] = "Invalid Email or Password"
      render :signin, status: :unprocessable_entity
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to guest_landing_page_path, notice: "Logout Successfully"
  end
  def signup
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.role = "admin"

    if @user.save
      session[:user_id] = @user.id
      redirect_to user_dashboard_page_path, notice: "Account Created Successfully, Welcome User"
    else
      render :signup, status: :unprocessable_entity, notice: "credential doesn't match"
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
