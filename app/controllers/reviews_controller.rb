class ReviewsController < ApplicationController
  before_action :admin_user, only: :destroy

  def create
    @review = Review.new(review_params)
    @review.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    Review.find(params[:id]).destroy
    flash[:success] = "キープリストから削除しました"
    redirect_back(fallback_location: root_path)
  end

  private
  def review_params
    params.require(:review).permit(:shop_id, :user_id, :body)
  end
  
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
