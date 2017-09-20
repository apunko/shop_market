class CartProductsController < ApplicationController
  before_action :set_shop
  before_action :set_cart, only: [:create, :destroy, :update]
  before_action :set_cart_product, only: :update

  def update
    @cart_product.update(update_cart_product_params)

    redirect_to shop_carts_path
  end

  def create
    product = @shop.products.find(params[:cart_product][:product_id])
    package = product.packages.find(params[:cart_product][:package_id])

    if @cart
      cart_product = @cart.add_product(product, package, params[:amount])
      if cart_product.save
        flash[:notice] = "Product was added!"
        redirect_to(request.referrer || product_path(product))
      else
        flash[:errors] = @cart_product.errors
        redirect_to(request.referrer || product_path(product))
      end
    else
      session[:shops][@shop.title].reject! do |cart_product|
        cart_product["product_id"].to_s == cart_product_params[:product_id] && cart_product["package_id"].to_s == cart_product_params[:package_id] 
      end

      cart_product = CartProduct.new(cart_product_params)
      session[:shops][@shop.title] << cart_product
    end
  end

  def destroy
    if current_user
      cart_product = @cart.cart_products.find(params[:id])
      cart_product.destroy
    else
      session[:shops][@shop.title].reject! do |cart_product|
        cart_product["product_id"].to_s == params[:cart_product][:product_id] && cart_product["package_id"].to_s == params[:cart_product][:package_id] 
      end
    end

    flash[:notice] = "Removed from cart!"
    redirect_to shop_carts_path
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
    end
  end

  def set_cart_product
    @cart_product = @cart.cart_products.find(params[:id])
  end

  def cart_product_params
    params.require(:cart_product).permit(:product_id, :package_id, :amount)
  end

  def update_cart_product_params
    params.require(:cart_product).permit(:amount)
  end
end
