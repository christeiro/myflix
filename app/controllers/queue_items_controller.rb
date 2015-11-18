class QueueItemsController < ApplicationController
  before_action :require_user
  def index
    @queue_items = current_user.queue_items.order("order_id ASC")
  end

  def create
    queue_item = QueueItem.new(video_id: params[:video_id], user_id: current_user.id)
    if queue_item.save
      redirect_to my_queue_path
    else 
      flash[:error] = "Unable to add video to queue!"
      redirect_to back
    end
  end
end