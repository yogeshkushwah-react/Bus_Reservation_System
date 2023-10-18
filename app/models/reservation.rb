class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :bus
  belongs_to :seat

  scope :available, -> {
      self.where(reservation_for: params[reservation_for]).exists?(seat_id: seat.id)
    }

  def self.create_reservation(bus, user, seat_ids, reservation_for)
    reservation = seat_ids && seat_ids.map { |seat_id|
    already_booked = bus.reservations.find_by(seat_id: seat_id, reservation_for: reservation_for)
      bus.reservations.create(user_id: user.id, seat_id: seat_id, reservation_for: reservation_for) unless already_booked
    }
  end
end
