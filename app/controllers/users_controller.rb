class UsersController < ApplicationController
  before_action :set_user
  before_action :redirect_to_root

  def show
    @posts = @user.posts
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def redirect_to_root
      redirect_to('/') if @user.id != current_user.id
    end
end
