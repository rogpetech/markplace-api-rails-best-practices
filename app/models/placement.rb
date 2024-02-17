class Placement < ApplicationRecord
  belongs_to :order, inverse_of: :placements
  belongs_to :product, inverse_of: :placements


  before_create :decrement_product_quantity!

  def decrement_product_quantity!
    self.product.decrement!(:quantity, quantity)
  end
end
