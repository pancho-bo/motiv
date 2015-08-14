class PricesController < ApplicationController
  before_action :authenticate_user!
  
  before_action :set_product
  before_action :set_price, only: [:show, :edit, :update, :destroy]
  
  def new
    @price = @product.prices.build
  end
  
  def create 
    @price = @product.prices.build(price_params)
    if @price.save
      flash[:notice] = 'Price assigned'
      redirect_to [@product, @price]
    else
      flash[:alert] = 'Price has not been assigned' 
      render "new"
    end 
  end
  
  def show
    
  end

  private
  def set_product
    @product = Product.find(params[:product_id])
  end
  
  def set_price
    @price = @product.prices.find(params[:id])
  end
  
  def price_params
    params.require(:price).permit(:price, :start_date, :end_date)
  end  
  
end
