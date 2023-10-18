class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :created_at, :updated_at, :token, :product_ids
  has_many :products, embed: :id
end
