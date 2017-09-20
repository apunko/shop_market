class Order < ApplicationRecord
  belongs_to :shop
  belongs_to :user
  has_many :order_products, dependent: :destroy
  paginates_per 10

  after_save :update_packages

  private

  def update_packages
    self.order_products.each do |op|
      op.package.amount -= op.amount
      unless op.package.save
        raise "Doesn't have enough packages of the product"
      end
    end
  end
end
