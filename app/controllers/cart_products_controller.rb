class CartProductsController < ApplicationController
  before_action :set_shop
  before_action :set_cart, only: :create

  def create
    binding.pry
    product = @shop.products.find(params[:cart_product][:product_id])
    package = product.packages.find(params[:cart_product][:package_id])

    binding.pry
    if @cart
      cart_product = @cart.add_product(product, package, params[:amount])
      if @cart_product.save
        flash[:notice] = "Product was added!"
        redirect_to(request.referrer || product_path(product))
      else
        flash[:errors] = @cart_product.errors
        redirect_to(request.referrer || product_path(product))
      end
    else
      binding.pry
      cart_product = CartProduct.new(cart_product_params)
      session[:shops][@shop.title][:cart_products] << cart_product
      binding.pry
    end
  end

  def destroy
  end

  private 

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end

  def set_cart
    if current_user
      @cart = Cart.find_by(user_id: current_user.id, shop_id: @shop.id)
      unless @cart
        @cart = Cart.create(user_id: current_user.id, shop_id: @shop.id)
      end 
    else
      session[:shops] ||= {}
      session[:shops][@shop.title] ||= {}
      session[:shops][@shop.title][:cart_products] ||= []
    end
  end

  def cart_product_params
    params.require(:cart_product).permit(:product_id, :package_id, :amount)
  end
end
