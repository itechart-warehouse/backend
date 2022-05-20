# frozen_string_literal: true

class User < ApplicationRecord
  audited

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: Blacklist
  belongs_to :company
  belongs_to :user_role

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
