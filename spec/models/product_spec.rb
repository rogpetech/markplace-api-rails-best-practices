require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { FactoryBot.build :product }
  subject { product }

  it { should respond_to(:title) }
  it { should respond_to(:price) }
  it { should respond_to(:description) }
  it { should respond_to(:published) }
  it { should respond_to(:user_id) }

  # it { should not_be_published }

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :price }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
    it { should validate_presence_of :user_id }
  end

  describe 'associations' do
    it { should belong_to(:user).optional }
    it { should have_many(:placements) }
    it { should have_many(:orders).through(:placements) }
  end

  describe ".by_title" do
    before(:each) do
      @product1 = FactoryBot.create(:product, title: 'plasma TV')
      @product2 = FactoryBot.create(:product, title: 'Mesa')
      @product3 = FactoryBot.create(:product, title: 'Cama')
      @product4 = FactoryBot.create(:product, title: 'Microfone')
      @product5 = FactoryBot.create(:product, title: 'LCD TV')
    end

    context "when a TV title pattern is sent" do
      it 'returns the 2 products matching' do
        expect(Product.by_title('TV').count).to eql 2
      end

      it 'returns the products matching' do
        expect(Product.by_title('TV').sort).to match_array([@product1, @product5])
      end
    end
  end

  describe ".by_below_or_equal_to_price" do
    before(:each) do
      @product1 = FactoryBot.create(:product, price: 100)
      @product2 = FactoryBot.create(:product, price: 99)
      @product3 = FactoryBot.create(:product, price: 150)
      @product4 = FactoryBot.create(:product, price: 50)
      @product5 = FactoryBot.create(:product, price: 120)
    end

    it 'returns the products which are below or equal to the price' do
      expect(Product.by_below_or_equal_to_price(99).sort).to match_array([@product2, @product4])
    end
  end

  describe ".by_above_or_equal_to_price" do
    before(:each) do
      @product1 = FactoryBot.create(:product, price: 140)
      @product2 = FactoryBot.create(:product, price: 2100)
      @product3 = FactoryBot.create(:product, price: 500)
      @product4 = FactoryBot.create(:product, price: 250)
      @product5 = FactoryBot.create(:product, price: 50)
      @product6 = FactoryBot.create(:product, price: 10)
    end

    it 'returns the products which are above or equal to the price' do
      expect(Product.by_above_or_equal_to_price(500).sort).to match_array([@product3, @product2])
    end
  end

  describe ".by_recent" do
    before(:each) do
      @product1 = FactoryBot.create(:product, price: 100)
      @product2 = FactoryBot.create(:product, price: 50)
      @product3 = FactoryBot.create(:product, price: 150)
      @product4 = FactoryBot.create(:product, price: 99)
      @product5 = FactoryBot.create(:product, price: 258)

      @product3.price = 21
      @product5.price = 52
      @product3.save
      @product5.save
    end

    it 'returns the most updated records' do
      @product1.reload
      @product2.reload
      @product3.reload
      @product4.reload
      @product5.reload
      products = [@product1, @product2, @product4, @product3, @product5 ]
      expect(Product.by_recent).to match_array(products)
    end
  end

  describe ".search" do
    before(:each) do
      @product1 = FactoryBot.create(:product, price: 100, title: 'TV de LCD')
      @product2 = FactoryBot.create(:product, price: 50, title: 'Playstation 5 - Video Game')
      @product3 = FactoryBot.create(:product, price: 150, title: 'Fone de ouvido para música')
      @product4 = FactoryBot.create(:product, price: 99, title: 'MacBook - Computador')
    end

    context "when title TV and 100 a min price are set" do
      it 'returns an array with product' do
        search_params = { keyword: 'TV', min_price: 100 }
        expect(Product.search(search_params)).to match_array([@product1])
      end
    end

    context "when title Playstation, 200 as max price, and 80 as min price as set " do
      it 'returns the product array empty' do
        search_params = { keyword: 'playstation', min_price: 80, max_price: 200 }
        expect(Product.search(search_params)).to match_array([])
      end
    end

    context 'when an empty hash is sent' do
      it 'returns all the products' do
        products = [@product1, @product2, @product3, @product4]
        expect(Product.search({})).to match(products)
      end

      it 'retuns all the product when params empty' do
        products = [@product1, @product2, @product3, @product4]
        expect(Product.search()).to match(products)
      end
    end

    context 'when product_ids is present' do
      it 'returns the product from the ids' do
        search_params = { product_ids: [@product1.id, @product2.id] }
        expect(Product.search(search_params)).to match_array([@product1, @product2])
      end
    end
  end
end
