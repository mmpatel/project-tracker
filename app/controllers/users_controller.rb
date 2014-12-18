class UsersController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!
  before_filter :authenticate_admin!

  def index
    add_breadcrumb "Admin", :users_path
  end

  def edit
    @user = User.find(params[:id])
    add_breadcrumb "Admin", :users_path
    add_breadcrumb "User"
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path
    else
      render 'edit'
    end
  end
protected
  def user_params
  params.require(:user).permit(:admin, :blocked,:can_create_projects)
  end

end
