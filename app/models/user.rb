class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reservations
  has_many :seats, through: :reservations
  has_many :buses

  enum :role, { bus_owner: "bus_owner", user: "user", admin: "admin" }
end
