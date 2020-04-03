# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :redirect_to_root, only: [:edit, :update, :close, :reopen, :destroy]
  before_action :get_region, only: [:index, :create, :update]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
