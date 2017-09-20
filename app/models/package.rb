class Package < ApplicationRecord
  belongs_to :product

  validates :amount, numericality: { greater_than: -1 }
end
