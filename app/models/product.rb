class Product < ApplicationRecord
  include PgSearch
  belongs_to :shop

  pg_search_scope :search_full_text, against: [:title, :description]
end
