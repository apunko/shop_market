class ShopAdmin::ProductsController < ApplicationController
  include ShopAdmin

  before_action :set_product, only: [:destroy, :update, :edit]

  def index
    initialize_table
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

  def initialize_table
    @filterrific = initialize_filterrific(
      Product,
      params[:filterrific],
      select_options: {
        sorted_by: Product.options_for_sorted_by,
        with_category_id: Category.options_for_select
      },
      persistence_id: 'shared_key'
    ) or return

    @products = @filterrific.find.where(shop_id: @shop.id).includes(:category).page(params[:page])
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :category_id, {images: []}, packages_attributes: [:id, :title, :amount, :_destroy])
  end
end
