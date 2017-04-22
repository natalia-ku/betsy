class Merchant < ApplicationRecord
  has_many :products

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, format: /.+@.+/

  def self.from_github(auth_hash)
    merchant = Merchant.new
    merchant.username = auth_hash["info"]["nickname"]
    merchant.email = auth_hash["info"]["email"]
    merchant.oauth_id = auth_hash["uid"]
    merchant.oauth_provider = "github"
    return merchant
  end
end
