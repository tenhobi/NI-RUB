class UsersController < ApplicationController
  before_action :set_user, only: %i[ show ]

  # GET /users/:username
  def show
    if @user
      @posts = Post.where(user_id: @user.id)
    end
  end

  # GET /users/search/:username
  def search
    @users = User.where("username LIKE ?", "%#{params[:username]}%").limit(20)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by(username: params[:username])
  end
end
