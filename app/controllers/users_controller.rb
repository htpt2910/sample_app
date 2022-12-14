class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(show create new)
  before_action :find_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @pagy, @users = pagy User.where activated: true
  end

  def show
    @pagy, @micropost = pagy @user.microposts.recents
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "users_controller.info"
      redirect_to root_url
    else
      flash[:danger] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "users_controller.update_success"
      redirect_to @user
    else
      flash[:danger] = t "users_controller.update_fail"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "users_controller.delete_success"
    else
      flash[:danger] = t "users_controller.delete_fail"
    end

    redirect_to users_url
  end

  def following
    @title = t "following.title"
    @pagy, @users = pagy @user.following
    render "show_follow"
  end

  def followers
    @title = t "follower.title"
    @pagy, @users = pagy @user.followers
    render "show_follow"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "users_controller.not_found"
    redirect_to root_path
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
