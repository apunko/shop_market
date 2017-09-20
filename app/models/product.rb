class Product < ApplicationRecord
  include PgSearch
  include SortableTables
  
  filterrific(
    default_filter_params: { sorted_by: 'title_desc' },
    available_filters: [
      :sorted_by,
      :with_category_id,
      :search_text
    ]
  )

  mount_uploaders :images, ImageUploader
  belongs_to :shop
  belongs_to :category
  has_many :packages, dependent: :destroy
  accepts_nested_attributes_for :packages, allow_destroy: true

  before_create :package_check

  paginates_per 10

  pg_search_scope :search_full_text, against: [:title, :description]

  scope :search_text, lambda { |text|
    return nil  if text.blank?
    
    search_full_text(text)
  }

  scope :with_category_id, lambda { |category_ids|
    where(category_id: [*category_ids])
  }

  private 

  def package_check
    self.packages << Package.new(title: self.title) unless self.packages.any?
  end
end
