class Cart < ApplicationRecord
  belongs_to :shop
  belongs_to :user
  has_many :cart_products, dependent: :destroy

  def add_product(product, package, amount)
    cart_product = cart_products.find_by(product_id: product.id, package_id: package)
    if cart_product
      cart_product.amount = amount
    else
      cart_product = cart_products.build(product_id: product.id, package_id: package.id, amount: amount)
    end
    
    cart_product
  end
end
