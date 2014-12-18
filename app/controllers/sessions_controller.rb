class SessionsController < ApplicationController

  def new
    if current_user
      redirect_to user_projects_path(current_user)
    end
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    after_sign_in_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

protected

  def after_sign_in_path
    if current_user and !current_user.is_blocked?
      redirect_to user_projects_path(current_user)
    else
      redirect_to signout_path
      flash[:error]="You need to be unblocked by admin."
    end
  end

end
