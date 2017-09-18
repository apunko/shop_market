class Product < ApplicationRecord
  include PgSearch
  belongs_to :shop
  belongs_to :category
  has_many :packages
  accepts_nested_attributes_for :packages, allow_destroy: true

  pg_search_scope :search_full_text, against: [:title, :description]
end
