class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @review.save
    redirect_back(fallback_location: root_path)
  end

  private
  def review_params
    params.require(:review).permit(:shop_id, :user_id, :body)
  end
end
