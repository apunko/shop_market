class ProductsController < ApplicationController
  before_action :set_shop
  before_action :set_product, only: :show

  def index
  end

  def show
  end

  private 

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
