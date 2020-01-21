class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :role, :name, :phone
  has_one :advertiser_info
end
