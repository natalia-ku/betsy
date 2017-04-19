class Order < ApplicationRecord
  has_many :order_products
  has_many :products, through: :order_products

  validates :status,  presence: true,
                        inclusion: { in: %w(pending paid) }

 #validates :order_products,  presence: true



end
