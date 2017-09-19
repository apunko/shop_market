class ShopAdmin::CategoriesController < ApplicationController
  before_action :set_shop
  before_action :set_category, only: [:destroy, :update]

  def index
    @filterrific = initialize_filterrific(
      Category,
      params[:filterrific],
      select_options: {
        sorted_by: Category.options_for_sorted_by,
      },
      persistence_id: 'shared_key'
    ) or return

    @categories = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    create_params = category_params
    create_params[:shop_id] = params[:shop_id]
    @category = Category.create(create_params)
  end

  def update
    @category.update(category_params)
  end

  def destroy
    @category.destroy
  end

  private 

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:title)
  end
end
