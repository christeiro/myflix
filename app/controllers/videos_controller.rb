class VideosController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
  end

  def search
    @videos = Video.search_by_title(params[:title])
    flash[:message] = 'No videos found for your search criteria' if @videos.blank?
    render 'search'
  end
end