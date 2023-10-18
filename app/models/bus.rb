class Bus < ApplicationRecord
  belongs_to :bus_owner, class_name: "User"
  has_many :seats
  has_many :reservations
  has_many :users, through: :reservations
  enum :status, [:approved, :rejected]
  scope :search, ->(query) {
          Bus.where("name LIKE ? OR source_route LIKE ? OR destination_route LIKE ?",
                    Bus.sanitize_sql_like(query) + "%", Bus.sanitize_sql_like(query) + "%", Bus.sanitize_sql_like(query) + "%")
        }

  def create_seats
    self.no_of_seats.times { |seat|
      self.seats.new(seat_no: seat + 1)
    }
  end
end
