class Shop < ApplicationRecord
  include SortableTables
  belongs_to :user
  has_many :products
  has_many :orders, dependent: :destroy
  has_many :categories, dependent: :destroy

  paginates_per 10
end
