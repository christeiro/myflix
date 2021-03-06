class VideosController < ApplicationController
  before_action :require_user

  def index
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
    @reviews = @video.reviews
  end

  def search
    @videos = Video.search_by_title(params[:title])
    flash[:message] = 'No videos found for your search criteria' if @videos.blank?
    render 'search'
  end

  def review
    review = Review.create()
  end
  private
  def review_params

  end
end