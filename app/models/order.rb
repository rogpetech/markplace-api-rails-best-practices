class Order < ApplicationRecord
  include ActiveModel::Validations

  before_validation :set_total!, if: -> { (total.nil? || total.zero?) && products.any? }

  belongs_to :user
  has_many :placements
  has_many :products, through: :placements

  validates :total, presence: true,
                      numericality: { greater_than_or_equal_to: 0 }
  validates :user_id, presence: true

  validates_with EnoughProductsValidator

  def set_total!
    self.total = 0
    placements.each do |placement|
      self.total += placement.product.price * placement.quantity
    end
  end

  def build_placements_with_product_ids_and_quantities(product_ids_quantities)
    product_ids_quantities.each do |product_ids_quantitiy|
      id, quantity = product_ids_quantitiy
      placements.build(product_id: id, quantity: quantity)
    end
  end
end
