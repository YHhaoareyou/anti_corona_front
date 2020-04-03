class UsersController < ApplicationController
  before_action :set_user
  before_action :redirect_to_root
  before_action :get_region
  #around_action :switch_locale

  def show
    @posts = @user.posts.page(params[:page])
  end

  def followed_posts
    @posts = current_user.followed_posts.where(open_status: 1).page(params[:page])
    # @closed_posts = current_user.followed_posts.where(open_status: 0)
  end

  private

    def set_user
      @user = User.find(current_user.id)
    end

    def redirect_to_root
      redirect_to('/') if @user.id != current_user.id
    end

    def get_region
      @region = Timeout::timeout(5) { Net::HTTP.get_response(URI.parse('http://api.hostip.info/country.php?ip=' + request.remote_ip )).body } rescue "JP"
    end
end
