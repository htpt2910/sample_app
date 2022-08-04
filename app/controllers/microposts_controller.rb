class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build micropost_params
    @micropost.image.attach params[:micropost][:image]
    if @micropost.save
      flash[:success] = t "post.create_success"
      redirect_to root_url
    else
      create_micropost_fail
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t "post.delete_success"
    else
      flash[:danger] = t "post.delete_fail"
    end

    redirect_to request.referer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit :content, :image
  end

  def create_micropost_fail
    flash[:danger] = t "post.create_fail"
    @pagy, @feed_items = pagy current_user.feed
    render "static_pages/home"
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    return if @micropost

    flash[:danger] = t "post.not_available"
    redirect_to root_url
  end
end
