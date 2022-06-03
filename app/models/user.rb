# frozen_string_literal: true

class User < ApplicationRecord
  audited

  before_validation :generate_password, on: :create
  # Include default devise modules. Others available are:
  # :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: Blacklist
  belongs_to :company
  belongs_to :user_role
  scope :by_name,-> (search){
    last_name,first_name = search.split
    query = "last_name ILIKE '#{last_name}%'"
    query += "and first_name  ILIKE '#{first_name}%'" if first_name.present?
    where(query)
  }

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: email_regex },
                    uniqueness: { case_sensitive: false }

  UserRole::AVAIBLE_CODE.each do |code|
    define_method "#{code}?" do
      user_role.code == code
    end
  end

  private

  def generate_password
    self.password = SecureRandom.hex(8)
  end
end
