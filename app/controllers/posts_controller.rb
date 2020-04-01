class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :close, :reopen, :destroy]
  before_action :redirect_to_root, only: [:edit, :update, :close, :reopen, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    if params['posts']
      search_params = params['posts'].select{ |k, value| value != '0' && !value.blank? }
      @posts = Post.search(search_params)
    else
      @posts = Post.where(open_status: 1)
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
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
      preferred_date_time: params[:post][:preferred_date_time]
    )

    @demand = Demand.new(
      post_id: @post.id,
      mask: params[:post][:demand_mask],
      medical_mask: params[:post][:demand_medical_mask],
      hand_sanitizer_spray: params[:post][:demand_hand_sanitizer_spray],
      hand_sanitizer_gel: params[:post][:demand_hand_sanitizer_gel],
      alcohol_wet_wipe: params[:post][:demand_alcohol_wet_wipe],
      tissue_paper: params[:post][:demand_tissue_paper],
      toilet_paper: params[:post][:demand_toilet_paper],
      other: params[:post][:demand_other].blank? ? nil : params[:post][:demand_other]
    )
    @supply = Supply.new(
      post_id: @post.id,
      mask: params[:post][:supply_mask],
      medical_mask: params[:post][:supply_medical_mask],
      hand_sanitizer_spray: params[:post][:supply_hand_sanitizer_spray],
      hand_sanitizer_gel: params[:post][:supply_hand_sanitizer_gel],
      alcohol_wet_wipe: params[:post][:supply_alcohol_wet_wipe],
      tissue_paper: params[:post][:supply_tissue_paper],
      toilet_paper: params[:post][:supply_toilet_paper],
      other: params[:post][:supply_other].blank? ? nil : params[:post][:supply_other]
    )

    respond_to do |format|
      if @demand.save && @supply.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @demand.errors + @supply.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @demand = Demand.find(@post.demand_id)
    @supply = Supply.find(@post.supply_id)

    post_update_hash = {
      exchange_method: params[:post][:exchange_method],
      preferred_place: params[:post][:preferred_place],
      preferred_date_time: params[:post][:preferred_date_time]
    }

    demand_update_hash = {
      mask: params[:post][:demand_mask].blank? ? nil : params[:post][:demand_mask],
      medical_mask: params[:post][:demand_medical_mask].blank? ? nil : params[:post][:demand_medical_mask],
      hand_sanitizer_spray: params[:post][:demand_hand_sanitizer_spray].blank? ? nil : params[:post][:demand_hand_sanitizer_spray],
      hand_sanitizer_gel: params[:post][:demand_hand_sanitizer_gel].blank? ? nil : params[:post][:demand_hand_sanitizer_gel],
      alcohol_wet_wipe: params[:post][:demand_alcohol_wet_wipe].blank? ? nil : params[:post][:demand_alcohol_wet_wipe],
      tissue_paper: params[:post][:demand_tissue_paper].blank? ? nil : params[:post][:demand_tissue_paper],
      toilet_paper: params[:post][:demand_toilet_paper].blank? ? nil : params[:post][:demand_toilet_paper],
      other: params[:post][:demand_other].blank? ? nil : params[:post][:demand_other]
    }
    supply_update_hash = {
      mask: params[:post][:supply_mask].blank? ? nil : params[:post][:supply_mask],
      medical_mask: params[:post][:supply_medical_mask].blank? ? nil : params[:post][:supply_medical_mask],
      hand_sanitizer_spray: params[:post][:supply_hand_sanitizer_spray].blank? ? nil : params[:post][:supply_hand_sanitizer_spray],
      hand_sanitizer_gel: params[:post][:supply_hand_sanitizer_gel].blank? ? nil : params[:post][:supply_hand_sanitizer_gel],
      alcohol_wet_wipe: params[:post][:supply_alcohol_wet_wipe].blank? ? nil : params[:post][:supply_alcohol_wet_wipe],
      tissue_paper: params[:post][:supply_tissue_paper].blank? ? nil : params[:post][:supply_tissue_paper],
      toilet_paper: params[:post][:supply_toilet_paper].blank? ? nil : params[:post][:supply_toilet_paper],
      other: params[:post][:supply_other].blank? ? nil : params[:post][:supply_other]
    }

    respond_to do |format|
      if @post.update_attributes(post_update_hash) && @demand.update_attributes(demand_update_hash) && @supply.update_attributes(supply_update_hash)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @demand.errors + @supply.errors, status: :unprocessable_entity }
      end
    end
  end

  def close
    respond_to do |format|
      if @post.update(open_status: 0)
        format.html { redirect_to @post, notice: 'Post was successfully closed.' }
        format.json { render :index, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def reopen
    respond_to do |format|
      if @post.update(open_status: 1)
        format.html { redirect_to @post, notice: 'Post was successfully reopened.' }
        format.json { render :show, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
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
