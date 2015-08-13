class Sale < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  validates :quantity, presence: true
  validates :quantity, numericality: {only_integer: true, greater_than: 0}
  validates :date,  presence: true

end
