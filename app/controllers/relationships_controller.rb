class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :find_user, only: :create
  before_action :find_to_unfollow, only: :destroy

  def create
    current_user.follow @user
    redirect_to @user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def destroy
    current_user.unfollow @user
    redirect_to @user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def find_user
    @user = User.find_by id: params[:followed_id]
    return if @user

    flash[:danger] = t "user.not_found"
    redirect_to root_url
  end

  def find_to_unfollow
    @user = Relationship.find_by(id: params[:id]).followed
    return if @user

    flash[:danger] = t "user.not_found"
    redirect_to root_url
  end
end
