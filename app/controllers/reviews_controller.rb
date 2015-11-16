class ReviewsController < ApplicationController
  before_action :require_user

  def create
    @video = Video.find(params[:video_id])
    @review = @video.reviews.build(params.require(:review).permit(:rating, :description))
    @review.user = current_user

    if @review.save
      flash[:notice] = "Your rating to the video was added"
      redirect_to video_path(@video)
    else
      redirect_to video_path(@video)
    end
  end
end