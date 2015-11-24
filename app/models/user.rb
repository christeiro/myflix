class User < ActiveRecord::Base
  has_many :reviews
  has_many :queue_items, -> { order(:position) }
  
  validates_presence_of :email, :password_digest, :full_name
  validates_uniqueness_of :email

  has_secure_password

  def normalize_queue_item_positions
    queue_items.each_with_index do |item, index| 
      item.update_attributes(position: index+1)
    end
  end
end