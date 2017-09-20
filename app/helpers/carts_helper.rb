module CartsHelper
  def get_shop_cart(shop, user)
    session[:shops] ||= {}
    session[:shops][@shop.title] ||= []

    if user
      cart = Cart.find_by(user_id: user.id, shop_id: shop.id)
      unless cart
        cart = Cart.new(user_id: user.id, shop_id: @shop.id)
        session[:shops][@shop.title].each do |cart_product_params|
          cart.cart_products << CartProduct.new(cart_product_params)   
        end
      end 
    else
      cart = Cart.new(shop_id: shop.id)
      session[:shops][shop.title].each do |cart_product_params|
        cart.cart_products << CartProduct.new(cart_product_params)  
      end
    end

    cart
  end
end
