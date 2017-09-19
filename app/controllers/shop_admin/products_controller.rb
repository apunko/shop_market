class ShopAdmin::ProductsController < ApplicationController
  before_action :set_shop
  before_action :set_product, only: [:destroy, :update, :edit]

  def index
  end

  def create
    create_params = product_params
    create_params[:shop_id] = params[:shop_id]
    @product = Product.create(create_params)
  end

  def update
    @product.update(product_params)
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

  def product_params
    params.require(:product).permit(:title, :description, :category_id, {images: []}, packages_attributes: [:id, :title, :amount, :_destroy])
  end
end
