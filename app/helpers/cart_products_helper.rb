module CartProductsHelper
  def get_cart_product(product, package)
    cart_product = CartProduct.find_by(product: product, package: package)
    cart_product ? cart_product : CartProduct.new(product: product, package: package)
  end
end
