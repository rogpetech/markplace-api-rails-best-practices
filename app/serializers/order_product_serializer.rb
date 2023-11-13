class OrderProductSerializer < ActiveModel::Serializer
  def include_user?
    false
  end
end
