require 'rails_helper'

RSpec.describe Order, type: :model do
  let!(:order) { FactoryBot.build(:order) }
  subject { order }

  describe 'respond_to' do
    it { should respond_to(:total) }
    it { should respond_to(:user_id) }
  end

  describe 'validations' do
    it { should validate_presence_of(:total) }
    it { should validate_presence_of(:user_id) }
    it { should validate_numericality_of(:total).is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
   it { should belong_to(:user) }
  end
end
