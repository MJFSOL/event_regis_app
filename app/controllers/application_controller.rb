class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_login
    unless current_user
      redirect_to auth_signin_page_path
    end
  end

  def require_admin
    unless current_user&.role == "admin"
      redirect_to guest_landing_page_path
    end
  end
end
