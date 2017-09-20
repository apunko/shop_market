class OrdersController < ApplicationController
  before_action :set_shop
  before_action :set_order, only: :show

  def new
  end

  def show
  end

  def create
    if current_user
      @order = Order.new(price: fix_price, user: current_user, shop: @shop)
      cart = Cart.find_by(user_id: current_user.id, shop_id: @shop.id)
      cart.cart_products.each do |cart_product|
        @order.order_products << OrderProduct.new(product: cart_product.product, package: cart_product.package, amount: cart_product.amount)
      end

      if @order.save
        cart.cart_products = []
      end
      
      redirect_to shop_order_path(@shop, @order)
    else
      flash[:alert] = "Please, log in to make orders!"
      redirect_to shop_carts_path(@shop)
    end
  end

  private

  def fix_price
    1000
  end

  def set_order
    @order = @shop.orders.find(params[:id])
  end

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end
end
