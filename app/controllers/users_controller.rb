class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(show create new)
  before_action :find_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @pagy, @users = pagy(User.all)
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t("alert.welcome")
      redirect_to @user
    else
      flash[:danger] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t("users_controller.update_success")
      redirect_to @user
    else
      flash[:danger] = t("users_controller.update_fail")
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t("users_controller.delete_success")
    else
      flash[:danger] = t("users_controller.delete_fail")
    end

    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t("users_controller.not_found")
    redirect_to root_path
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t("users_controller.login_request")
    redirect_to login_url
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end
end
