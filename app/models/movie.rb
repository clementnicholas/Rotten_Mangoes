class Movie < ActiveRecord::Base

  has_many :reviews

  mount_uploader :poster, PosterUploader

  validates :title, presence: true

  validates :director, presence: true

  validates :runtime_in_minutes, numericality: { only_integer: true }

  validates :description, presence: true

  validates :poster, presence: true

  validates :release_date, presence: true

  validate :release_date_is_in_the_past


  def review_average
    reviews.size > 0 ? reviews.sum(:rating_out_of_ten)/reviews.size : "No reviews."
  end


  def self.search_title_director(title, director)
      # return self.all if title.blank? && director.blank?
      if title && director.blank?
        result = self.where("title like ?", "%#{title}%")      
      elsif title.blank? && director
        result = self.where("director like ?", "%#{director}%")
      elsif title && director
        result = self.where("title like ? or director like ?", "%#{title}%", "%#{director}%") 
      else
        self.all
      end      
  end

  def self.search_runtime(runtime)
    case runtime
    when '<90' then self.where("runtime_in_minutes < ?", 90)
    when '90<x<120' then self.where("runtime_in_minutes < ? ", 90).where("runtime_in_minutes > ? ", 120)
    when '>120' then self.where("runtime_in_minutes > ? ", 120)
    else self.all
    end
  end
      
      
      

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end

end
