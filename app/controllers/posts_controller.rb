class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :close, :reopen, :destroy]
  before_action :redirect_to_root, only: [:edit, :update, :close, :reopen, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    if params['posts']
      search_params = params['posts'].select{ |k, value| value != '0' && !value.blank? }
      @posts = Post.where(region: @region).search(search_params).order(created_at: "DESC").page(params[:page])
    else
      @posts = Post.where(region: @region).where("open_status = 1 OR user_id = #{current_user.id}").order(created_at: "DESC").page(params[:page])
    end
    @followed_post_ids = current_user.followed_posts.pluck(:id)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.create(
      user_id: current_user.id,
      exchange_method: params[:post][:exchange_method],
      preferred_place: params[:post][:preferred_place],
      preferred_date_time: params[:post][:preferred_date_time],
      phone: params[:post][:phone],
      email: params[:post][:email],
      other_sns_urls: params[:post][:other_sns_urls].reject{ |url| url.empty? }.join(','),
      region: @region
    )

    @demand = Demand.new(
      post_id: @post.id,
      mask: params[:post][:demand_mask],
      medical_mask: params[:post][:demand_medical_mask],
      hand_sanitizer: params[:post][:demand_hand_sanitizer],
      bleach_solution: params[:post][:demand_bleach_solution],
      alcohol_wet_wipe: params[:post][:demand_alcohol_wet_wipe],
      tissue_paper: params[:post][:demand_tissue_paper],
      toilet_paper: params[:post][:demand_toilet_paper],
      other: params[:post][:demand_other].blank? ? nil : params[:post][:demand_other]
    )
    @supply = Supply.new(
      post_id: @post.id,
      mask: params[:post][:supply_mask],
      medical_mask: params[:post][:supply_medical_mask],
      hand_sanitizer: params[:post][:supply_hand_sanitizer],
      bleach_solution: params[:post][:supply_bleach_solution],
      alcohol_wet_wipe: params[:post][:supply_alcohol_wet_wipe],
      tissue_paper: params[:post][:supply_tissue_paper],
      toilet_paper: params[:post][:supply_toilet_paper],
      other: params[:post][:supply_other].blank? ? nil : params[:post][:supply_other]
    )

    respond_to do |format|
      if @demand.save && @supply.save
        format.html { redirect_to controller: 'users', action: 'show', id: current_user.id, notice: 'Post was successfully created.' }
        format.json { render "users/show/#{current_user.id}", status: :created }
      else
        format.html { render :new }
        format.json { render json: @demand.errors + @supply.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @demand = @post.demand
    @supply = @post.supply

    post_update_hash = {
      exchange_method: params[:post][:exchange_method],
      preferred_place: params[:post][:preferred_place],
      preferred_date_time: params[:post][:preferred_date_time],
      phone: params[:post][:phone],
      email: params[:post][:email],
      other_sns_urls: params[:post][:other_sns_urls].reject{ |url| url.empty? }.join(','),
      region: @region
    }

    demand_update_hash = {
      mask: params[:post][:demand_mask].blank? ? nil : params[:post][:demand_mask],
      medical_mask: params[:post][:demand_medical_mask].blank? ? nil : params[:post][:demand_medical_mask],
      hand_sanitizer: params[:post][:demand_hand_sanitizer].blank? ? nil : params[:post][:demand_hand_sanitizer],
      bleach_solution: params[:post][:demand_bleach_solution].blank? ? nil : params[:post][:demand_bleach_solution],
      alcohol_wet_wipe: params[:post][:demand_alcohol_wet_wipe].blank? ? nil : params[:post][:demand_alcohol_wet_wipe],
      tissue_paper: params[:post][:demand_tissue_paper].blank? ? nil : params[:post][:demand_tissue_paper],
      toilet_paper: params[:post][:demand_toilet_paper].blank? ? nil : params[:post][:demand_toilet_paper],
      other: params[:post][:demand_other].blank? ? nil : params[:post][:demand_other]
    }
    supply_update_hash = {
      mask: params[:post][:supply_mask].blank? ? nil : params[:post][:supply_mask],
      medical_mask: params[:post][:supply_medical_mask].blank? ? nil : params[:post][:supply_medical_mask],
      hand_sanitizer: params[:post][:supply_hand_sanitizer].blank? ? nil : params[:post][:supply_hand_sanitizer],
      bleach_solution: params[:post][:supply_bleach_solution].blank? ? nil : params[:post][:supply_bleach_solution],
      alcohol_wet_wipe: params[:post][:supply_alcohol_wet_wipe].blank? ? nil : params[:post][:supply_alcohol_wet_wipe],
      tissue_paper: params[:post][:supply_tissue_paper].blank? ? nil : params[:post][:supply_tissue_paper],
      toilet_paper: params[:post][:supply_toilet_paper].blank? ? nil : params[:post][:supply_toilet_paper],
      other: params[:post][:supply_other].blank? ? nil : params[:post][:supply_other]
    }

    respond_to do |format|
      if @post.update_attributes(post_update_hash) && @demand.update_attributes(demand_update_hash) && @supply.update_attributes(supply_update_hash)
        format.html { redirect_to controller: 'users', action: 'show', id: current_user.id, notice: 'Post was successfully updated.' }
        format.json { render "users/show/#{current_user.id}", status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @demand.errors + @supply.errors, status: :unprocessable_entity }
      end
    end
  end

  def close
    redirect_path = params['redirect_path'] == 'root' ? '/' : "/#{params['redirect_path']}"
    respond_to do |format|
      if @post.update(open_status: 0)
        format.html { redirect_to redirect_path, notice: 'Post was successfully closed.' }
        format.json { render redirect_path, status: :ok, location: @post }
      else
        format.html { render redirect_path }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def reopen
    redirect_path = params['redirect_path'] == 'root' ? '/' : "/#{params['redirect_path']}"
    respond_to do |format|
      if @post.update(open_status: 1)
        format.html { redirect_to redirect_path, notice: 'Post was successfully reopened.' }
        format.json { render redirect_path, status: :ok }
      else
        format.html { render redirect_path }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def follow
    @followed_posts_reference =  FollowedPostsReference.new(user_id: current_user.id, post_id: params[:post_id])
    respond_to do |format|
      if @followed_posts_reference.save
        format.html { redirect_to '/', notice: 'You followed a post.' }
        format.json { render '/', status: :ok }
      else
        format.html { render '/' }
        format.json { render json: @followed_posts_reference.errors, status: :unprocessable_entity }
      end
    end
  end

  def unfollow
    FollowedPostsReference.find_by(user_id: current_user.id, post_id: params[:post_id]).destroy
    redirect_path = params['redirect_path'] == 'root' ? '/' : "/#{params['redirect_path']}"
    respond_to do |format|
      format.html { redirect_to redirect_path, notice: 'Post is unfollowed.' }
      format.json { head :no_content }
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit!
    end

    def redirect_to_root
      redirect_to('/') if @post.user_id != current_user.id
    end
end
