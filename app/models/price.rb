class Price < ActiveRecord::Base
  belongs_to :product
  
  validates :price, presence: true
  validates :price, numericality: true
  validates :start_date, presence: true
  validates :end_date, presence: true

end
