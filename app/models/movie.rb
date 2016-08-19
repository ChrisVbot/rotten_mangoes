class Movie < ApplicationRecord
  
  SEARCH_OPTIONS = {
    0 => 'Search all movies by runtime',
    1 => 'Less than 90 minutes',
    2 => 'Between 90 and 120 minutes',
    3 => 'Over 120 minutes'
  }

  scope :title_director_query, -> (search) {where("title LIKE ? OR director LIKE ?", "%#{search}%", "%#{search}%")}
  scope :runtime_query1, -> (runtime) {where("runtime_in_minutes < ?", 90)}
  #checks for runtimes between 90 and 120 minutes
  scope :runtime_query2, -> (runtime) {where("runtime_in_minutes > ? AND runtime_in_minutes < ?", 90, 120)}
  #checks for runtimes over 120 minutes
  scope :runtime_query3, -> (runtime) {where("runtime_in_minutes > ?", 120)}


  has_many :reviews
  mount_uploader :image, ImageUploader


  validates :title, presence: true
  validates :director, presence: true
  validates :runtime_in_minutes, numericality: {only_integer: true}
  validates :description, presence: true, length:{maximum: 215}
  validates :release_date, presence: true

  validate :release_date_is_in_the_past

  def review_average
    reviews.sum(:rating_out_of_ten) / reviews.size unless reviews.empty?
  end 


  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end


end
