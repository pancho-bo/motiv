class PricesController < ApplicationController
  
  before_action :set_product
  
  def new
    @price = @product.prices.build
  end

  private
  def set_product
    @product = Product.find(params[:product_id])
  end
end
