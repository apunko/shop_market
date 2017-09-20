class Order < ApplicationRecord
  belongs_to :shop
  belongs_to :user
  has_many :order_products, dependent: :destroy

  paginates_per 10
end
