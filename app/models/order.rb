class Order < ApplicationRecord
  has_many :order_products
  has_many :products, through: :order_products

  def total_price
    op = OrderProduct.where(order_id: self.id)
    total = 0.0
    op.each do |product|
      total += product.subtotal
    end
    return total
  end
end
