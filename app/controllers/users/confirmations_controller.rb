# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  before_action :redirect_to_root, only: [:edit, :update, :close, :reopen, :destroy]
  before_action :get_region, only: [:index, :create, :update]
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  # def show
  #   super
  # end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end
end
