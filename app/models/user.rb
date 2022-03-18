# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: Blacklist
  belongs_to :company
  belongs_to :user_role

  validates :first_name, presence: true, length: { maximum: 25 }
  validates :last_name, presence: true, length: { maximum: 25 }
  validates :birth_date, presence: true
  validates :address, presence: true, length: { maximum: 100 }

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: email_regex },
            uniqueness: { case_sensitive: false }

  UserRole::AVAIBLE_CODE.each do |code|
    define_method "#{code}?" do
      self.user_role.code == code
    end
  end

end
