# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :birth_date, :address, :active
  belongs_to :company
  belongs_to :user_role
end
