class ShopsController < ApplicationController
  before_action :set_shop, only: :show

  def show
  end

  def index
    initialize_table
  end

  private

  def initialize_table
    @filterrific = initialize_filterrific(
      Shop,
      params[:filterrific],
      select_options: {
        sorted_by: Shop.options_for_sorted_by,
      },
      persistence_id: 'shared_key'
    ) or return

    @shops = @filterrific.find.page(params[:page])
  end

  def set_shop
    @shop = Shop.find(params[:id])
  end
end
