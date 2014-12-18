class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user



  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  rescue_from CanCan::AccessDenied do |exception|
  flash[:error] = "Access denied!"
  redirect_to root_path
  end

  def authenticate_user!
    if current_user.nil?
      redirect_to signout_path
    end
  end

  def authenticate_admin!
    if current_user and !current_user.is_admin?
      raise CanCan::AccessDenied.new("Not authorized!")
    end
  end
end
