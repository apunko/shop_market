class Category < ApplicationRecord
  include SortableTables

  belongs_to :shop
  has_many :products
  paginates_per 5
end
