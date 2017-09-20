module CartProductsHelper
  def get_cart_product(shop, user, product, package)
    cart = get_shop_cart(shop, user)
    cart_product = cart.cart_products.find_by(product: product, package: package)
    cart_product ? cart_product : CartProduct.new(product: product, package: package, amount: 1)
  end
end
