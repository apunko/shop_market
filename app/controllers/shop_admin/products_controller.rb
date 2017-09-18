class ShopAdmin::ProductsController < ApplicationController
  before_action :set_shop
  before_action :set_product, only: [:destroy, :update, :edit]

  def index
  end

  def create
  end

  def update
  end

  def edit
  end

  def new
    @product = Product.new
    @product.packages.build
  end

  def destroy
  end

  private 

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
