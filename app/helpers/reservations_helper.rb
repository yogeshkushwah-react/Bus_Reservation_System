module ReservationsHelper
  def alreadyBooked?(booked_seats, id)
    booked_seats.include?(id)
  end
end
