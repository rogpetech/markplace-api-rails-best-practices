class Product < ApplicationRecord
  belongs_to :user, optional: true
  has_many :placements
  has_many :orders, through: :placements
  
  validates :title, :user_id, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 },
                    presence: true
  scope :by_title, -> (title) { where("lower(title) LIKE ?", "%#{title.downcase}%") }
  scope :by_below_or_equal_to_price, -> (price) { where("price <= ?", price) }
  scope :by_above_or_equal_to_price, -> (price) { where("price >= ?", price) }
  scope :by_recent, -> { order(:updated_at) }
  

  def self.search(params = {})
    product_ids = params[:product_ids]
    keyword_params = params[:keyword]
    max_price_params = params[:max_price]
    min_price_params = params[:min_price]

    products = product_ids.present? ? Product.find(product_ids) : Product.all

    products = products.by_title(keyword_params) if keyword_params

    products = products.by_above_or_equal_to_price(max_price_params) if max_price_params
    products = products.by_below_or_equal_to_price(min_price_params) if min_price_params

    products = products.by_title(keyword_params) if keyword_params.present?

    products
  end
end
