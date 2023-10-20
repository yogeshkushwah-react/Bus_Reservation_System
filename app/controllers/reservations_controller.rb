class ReservationsController < ApplicationController
  before_action :authenticate_user!, except: [:new]
  before_action :set_bus

  def index
    @reservations = policy_scope(Reservation)
  end

  def new
    @reservation = Reservation.new
  end

  def create
    seat_ids = params[:reservation][:seat_id].reject(&:blank?)
    reservation_for = params[:reservation][:reservation_for]
    @reservation = Reservation.create_reservation(@bus, current_user, seat_ids, reservation_for)
    if @reservation
      redirect_to bus_reservations_path(@bus), notice: "Reservation successful"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @reservations = Reservation.find(params[:id])
    @reservations.destroy
    redirect_to bus_reservations_path(@bus), status: :see_other, alert: "Ticket cancelled successfully!"
  end

  def check_availability
    binding.pry
    @total_seats = @bus.seats
    @booked_seats = Reservation.select(seat_id).where(bus_id: params[:id], reservation_for: params[:reservation_date])
  end

  private

  def set_bus
    @bus = Bus.find(params[:bus_id])
  end
end
