class Price < ActiveRecord::Base
  belongs_to :product
  
  validates :price, presence: true
  validates :price, numericality: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :intersection_check
  
  def intersection_check
    errors.add(:start_date, 'Intersection of price') if Product.find(product_id).prices.where("start_date between ? and ? or end_date between ? and ?", start_date, end_date, start_date,  end_date).exists?

  end

end
