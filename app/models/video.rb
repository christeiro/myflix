class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, -> { order("created_at DESC") }
  has_many :queue_items

  validates_presence_of :title, :description

  def self.search_by_title(search_term)
    return [] if search_term.blank?
    where('lower(title) LIKE ?', "%#{search_term.downcase}%").order("created_at DESC")
  end

  def average_rating
    average_rating = 0
    if self.reviews.any?
      self.reviews.each do |r|
        average_rating += r.rating
      end
      average_rating = (average_rating / self.reviews.size).to_f.round(2)
    else
      average_rating = 0
    end
  end
end