class ReservationsController < ApplicationController
  before_action :authenticate_user!, except: [:new, :check_availability]
  before_action :set_bus

  def index
    reservation_date = params[:reservation_for]
    @reservations = policy_scope(@bus, policy_scope_class: ReservationPolicy::Scope)
    @reservations = @reservations.where(reservation_for: reservation_date) unless reservation_date.blank?
  end

  def new
    @reservation = Reservation.new
  end

  def create
    seat_ids = params[:seat_ids]
    reservation_for = params[:reservation_for]
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
    @total_seats = @bus.seats
    @booked_seats = Reservation.where(bus_id: params[:bus_id], reservation_for: params[:reservation_for]).pluck(:seat_id)

    render partial: "available_seats", locals: { total_seats: @total_seats, booked_seats: @booked_seats }
  end

  private

  def set_bus
    @bus = Bus.find(params[:bus_id])
  end
end
