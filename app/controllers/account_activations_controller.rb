class AccountActivationsController < ApplicationController
  before_action :find_user, only: :edit

  def edit
    if !@user.activated? && @user.authenticated?(:activation, params[:id])
      @user.activate
      log_in @user
      flash[:success] = t "account.activate_success"
      redirect_to @user
    else
      flash[:danger] = t "account.activate_fail"
      redirect_to root_url
    end
  end
end

def find_user
  @user = User.find_by email: params[:email]
  return if @user

  flash[:danger] = t "users_controller.not_found"
  redirect_to root_path
end
