class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :phone, :email, :active
end
