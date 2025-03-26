class Bus < ApplicationRecord
  belongs_to :bus_owner, class_name: "User"
  has_many :seats
  has_many :reservations
  has_many :users, through: :reservations

  has_one_attached :main_image

  enum :status, [:approved, :rejected, :pending], default: :pending
  scope :search, ->(query) {
          Bus.where("name LIKE ? OR source_route LIKE ? OR destination_route LIKE ?",
                    Bus.sanitize_sql_like(query) + "%", Bus.sanitize_sql_like(query) + "%", Bus.sanitize_sql_like(query) + "%")
        }
  validates :name, :source_route, :destination_route, presence: true
  validates :registration_no, uniqueness: { message: "%{value} has already been taken" }, format: { with: /\A[A-Z]{2}[ -]?[0-9]{2}[ -]?[A-Z]{1,2}[ -]?[0-9]{4}\z/, message: "Invalid registration number format", multiline: true }

  validates :no_of_seats, numericality: { only_integer: true, in: 10..50 }

  def create_seats
    self.no_of_seats.times { |seat|
      self.seats.new(seat_no: seat + 1)
    }
  end
end
