class ProductsController < ApplicationController
  before_action :set_shop
  before_action :set_product, only: :show

  def index
    initialize_table
  end

  def show
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

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end

  def set_product
    @product = @shop.products.includes(:packages).find(params[:id])
  end
end
