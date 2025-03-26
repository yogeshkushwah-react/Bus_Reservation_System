class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    render layout: "profile"
  end

  def user_reservation
    reservation_date = params[:reservation_for]
    @reservations = current_user.reservations
    @reservations = @reservations.where(reservation_for: reservation_date) unless reservation_date.blank?
  end
end
