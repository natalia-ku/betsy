class Order < ApplicationRecord
  has_many :order_products
  has_many :products, through: :order_products

  validates :status,  presence: true,
  inclusion: { in: %w(pending paid complete cancelled) }

  # validates :order_products,  presence: true

  with_options({if: :is_paid?}) do |order|

    order.validates :email, presence: true
    order.validates :mailing_address, presence: true
    order.validates :card_name, presence: true
    order.validates :credit_card, presence: true
    order.validates :cvv, presence: true
    order.validates :zip_code, presence: true
  end


  def is_paid?
    status == "paid"
  end

end
