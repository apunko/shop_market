class CartsController < ApplicationController
  include CartsHelper

  before_action :set_shop
  before_action :set_cart

  def index
  end

  private 

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end

  def set_cart
    @cart = get_shop_cart(@shop, current_user)

    if current_user && @cart.new_record? 
      @cart.save
      session[:shops][@shop.title] = nil
    end
  end
end
