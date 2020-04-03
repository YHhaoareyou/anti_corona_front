# frozen_string_literal: true

class Users::UnlocksController < Devise::UnlocksController
  before_action :redirect_to_root, only: [:edit, :update, :close, :reopen, :destroy]
  before_action :get_region, only: [:index, :create, :update]
  # GET /resource/unlock/new
  # def new
  #   super
  # end

  # POST /resource/unlock
  # def create
  #   super
  # end

  # GET /resource/unlock?unlock_token=abcdef
  # def show
  #   super
  # end

  # protected

  # The path used after sending unlock password instructions
  # def after_sending_unlock_instructions_path_for(resource)
  #   super(resource)
  # end

  # The path used after unlocking the resource
  # def after_unlock_path_for(resource)
  #   super(resource)
  # end
end
