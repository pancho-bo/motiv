class Product < ActiveRecord::Base

  has_many :prices
  has_many :sales

end
