class UsersController < ApplicationController
  def index
    @users = User.search_user params[:keyword]
    render json: @users
  end

  def edit
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to :root
    else
      redirect_to action: :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name,:email)
  end
end
