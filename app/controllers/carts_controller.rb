class CartsController < ApplicationController
  before_action :set_shop
  before_action :set_cart

  def index
  end

  private 

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end

  def set_cart
    session[:shops] ||= {}
    session[:shops][@shop.title] ||= []

    if current_user
      @cart = Cart.find_by(user_id: current_user.id, shop_id: @shop.id)
      unless @cart
        @cart = Cart.new(user_id: current_user.id, shop_id: @shop.id)
        session[:shops][@shop.title].each do |cart_product_params|
          @cart.cart_products << CartProduct.new(cart_product_params)   
        end
        @cart.save
        session[:shops][@shop.title] = nil
      end 
    else
      @cart = Cart.new(shop_id: @shop.id)
      session[:shops][@shop.title].each do |cart_product_params|
        @cart.cart_products << CartProduct.new(cart_product_params)  
      end
    end
  end
end
