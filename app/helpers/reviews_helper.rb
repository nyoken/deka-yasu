module ReviewsHelper
  def get_reviews(rest_id)
    @reviews = Review.where(shop_id: rest_id)
  end
end
