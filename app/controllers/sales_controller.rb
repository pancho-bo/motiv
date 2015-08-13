class SalesController < ApplicationController
  
  before_action :set_product
  
  def new
    fill_products
    if @product.nil?
      @sale = Sale.new
    else 
      @sale = @product.sales.build
    end 
  end
  
  def create
    if @product.nil?
      @sale = Sale.new(sale_params)
    else 
      @sale = @product.sales.build(sale_params)
    end 
    @sale.user = current_user
    if @sale.save
      flash[:notice] = "Sale has been added"
      if @product.nil? 
        redirect_to root_path
      else
        redirect_to @product
      end
    else
      flash[:alert] = "Sale has not been added"
      render "new"
    end
  end
  
private
  def set_product
    if params[:product_id].blank?
      @product = nil
    else
      @product = Product.find(params[:product_id])
    end
  end  
  
  def fill_products
    @products = Product.all
  end
  
  def sale_params
    params.require(:sale).permit(:quantity, :date)  
  end
end
