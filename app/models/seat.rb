class Seat < ApplicationRecord
  belongs_to :bus
  has_many :reservations
end
