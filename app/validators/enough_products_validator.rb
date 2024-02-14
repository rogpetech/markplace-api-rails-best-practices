class EnoughProductsValidator < ActiveModel::Validator
  def validate(record)
    record.placements.each do |placement|
      product = placement.product
      if placement.quantity > product.quantity
        message = "Is out of stock, just #{product.quantity} left"
        record.errors["#{product.title}"] << message
      end
    end
  end
end
