class QueueItemsController < ApplicationController
  before_action :require_user
  def index
    @queue_items = QueueItem.find_by(user_id: current_user)
    @queue_items = [] if @queue_items.nil?
  end  
end