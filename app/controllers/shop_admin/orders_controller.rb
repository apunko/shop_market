class ShopAdmin::OrdersController < ApplicationController
  include ShopAdmin

  def index
    @orders = @shop.orders.includes(:user).page(params[:page])
  end
end
