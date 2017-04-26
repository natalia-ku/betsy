class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true,  numericality:{:greater_than => 0 }

  validates :status,  presence: true,
  inclusion: { in: ["shipped", "not shipped"] }

  def subtotal
    return 0 if self.nil?
    return self.quantity * self.product.price
  end
end
