class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reservations, dependent: :destroy
  has_many :seats, through: :reservations
  has_many :buses, dependent: :destroy, foreign_key: "bus_owner_id"

  enum :role, { bus_owner: "bus_owner", user: "user", admin: "admin" }

  validates :email, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validate :password_validation, unless: -> { password.blank? }

  def password_validation
    rules = {
      " must contain at least one lowercase letter" => /[a-z]+/,
      " must contain at least one uppercase letter" => /[A-Z]+/,
      " must contain at least one digit" => /\d+/,
      " must contain at least one special character" => /[^A-Za-z0-9]+/,
    }

    rules.each do |message, regex|
      errors.add(:password, message) unless password.match(regex)
    end
  end
end
