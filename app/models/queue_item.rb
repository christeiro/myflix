class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validates_numericality_of :position, { only_integer: true }

  delegate :title, to: :video, prefix: :video
  delegate :category, to: :video

  def rating
    review = Review.where(user_id: user.id, video_id: video.id).first
    review.rating if review
  end

  def category_name
    category.name
  end

  def self.update_my_queue(items, user)
    begin
      self.update_queue_items(items,user)
      self.normalize_queue_item_positions(user)
    rescue ActiveRecord::RecordInvalid
      return false
    end
    return true
  end

  private
  def self.update_queue_items(items,user)
    ActiveRecord::Base.transaction do
      items.each do |queue_items_data|
        queue_item = self.find(queue_items_data["id"])
        queue_item.update_attributes!(position: queue_items_data["position"]) if queue_item.user == user
      end
    end
  end

  def self.normalize_queue_item_positions(user)
    user.queue_items.each_with_index do |item, index|
      item.update_attributes(position: index+1)
    end
  end

end