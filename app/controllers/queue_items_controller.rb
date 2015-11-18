class QueueItemsController < ApplicationController
  before_action :require_user
  def index
    @queue_item = QueueItem.find_by(user_id: current_user)
  end  
end