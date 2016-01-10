class ReviewsController < ApplicationController
  before_filter :require_user

  def create
    @business = Business.find_by(id: params[:business_id])
    @review = @business.reviews.new(params.require(:review).permit(:content))
    @review.user = current_user

    if @review.save
      flash[:notice] = "Thanks for your review!"
      redirect_to business_path(@business)
    else
      flash[:error] = "Reviews can't be blank."
      render 'businesses/show'
    end
  end
end