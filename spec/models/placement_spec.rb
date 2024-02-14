require 'rails_helper'

RSpec.describe Placement, type: :model do
  let!(:placement) { FactoryBot.create(:placement) }

  describe 'associations' do
    it { should belong_to(:order) }
    it { should belong_to(:product) }
  end

  describe 'respond_to' do
    it { should respond_to :order_id }
    it { should respond_to :product_id }
    it { should respond_to :quantity }
  end

  describe '#decrement_product_quantity!' do
    it 'does return descreases the product quantity by the placement quantity' do
      product = placement.product
      expect{ placement.decrement_product_quantity! }.to change{product.quantity}.by(-placement.quantity)
    end
  end
end
