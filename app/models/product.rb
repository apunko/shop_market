class Product < ApplicationRecord
  include PgSearch
  belongs_to :shop
  belongs_to :category

  pg_search_scope :search_full_text, against: [:title, :description]
end
