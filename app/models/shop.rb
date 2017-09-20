class Shop < ApplicationRecord
  include SortableTables
  belongs_to :user
  has_many :products

  paginates_per 10

  def search_products(text)
    Product.search_full_text(text).joins(:shop).where(shop_id: id)
  end
end
