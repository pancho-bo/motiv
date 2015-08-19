class Product < ActiveRecord::Base

  has_many :prices
  has_many :sales
  
  def current_price
    if self.prices.where('start_date < ? and end_date > ?', Time.now, Time.now).exists?
      self.prices.where('start_date < ? and end_date > ?', Time.now, Time.now).first.price
    else
      nil
    end
  end
end
