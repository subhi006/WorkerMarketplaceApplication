class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to assigned_tasks
    end
  end
  private
  def review_params
    params.expect(review: [ :user_id, :reviewer_id, :review, :rating ])
  end
end
