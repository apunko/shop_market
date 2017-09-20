class Product < ApplicationRecord
  include PgSearch
  include SortableTables
  
  mount_uploaders :images, ImageUploader
  belongs_to :shop
  belongs_to :category
  has_many :packages
  accepts_nested_attributes_for :packages, allow_destroy: true

  pg_search_scope :search_full_text, against: [:title, :description]

  scope :search_text, lambda { |text|
    return nil  if text.blank?
    
    search_full_text(text)
  }

  scope :with_category_id, lambda { |category_ids|
    where(category_id: [*category_ids])
  }
end
