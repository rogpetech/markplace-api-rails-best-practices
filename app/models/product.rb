class Product < ApplicationRecord
  belongs_to :user, optional: true

  validates :title, :user_id, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 },
                    presence: true
  scope :by_title, -> (title) { where("lower(title) LIKE ?", "%#{title.downcase}%") }
  scope :by_below_or_equal_to_price, -> (price) { where("price <= ?", price) }
  scope :by_above_or_equal_to_price, -> (price) { where("price >= ?", price) }
  scope :by_recent, -> { order(:updated_at) }
end
