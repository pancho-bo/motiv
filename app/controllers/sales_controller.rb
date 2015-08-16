class SalesController < ApplicationController
  before_action :authenticate_user!
  
  before_action :set_product
  
  def new
    fill_products
    if @product.nil?
      @sale = Sale.new
    else 
      @sale = @product.sales.build
    end 
  end

  def index_by_user
    @user = User.find(params[:user_id])
    @sales = @user.sales.includes(:product)
  end

  def index_by_product
    @product = Product.find(params[:product_id])
    @sales = @product.sales.includes(:user)
  end
  
  def create
    fill_products
    if @product.nil?
      @sale = Sale.new(sale_params)
    else 
      @sale = @product.sales.build(sale_params)
    end 
    @sale.user = current_user
    if @sale.save
      flash[:notice] = t('notices.sale.create')
      if @product.nil? 
        redirect_to root_path
      else
        redirect_to @product
      end
    else
      flash[:alert] = t('alerts.sale.create')
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
    params.require(:sale).permit(:quantity, :date, :product_id)  
  end
end
