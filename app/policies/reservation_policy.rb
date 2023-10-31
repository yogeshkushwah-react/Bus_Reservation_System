class ReservationPolicy < ApplicationPolicy
  attr_reader :user, :bus

  def initialize(user, bus)
    @user = user
    @bus = bus
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!

    def resolve
      if user.bus_owner? && scope.bus_owner == user
        scope.reservations
      else
        scope.reservations.where(user_id: user.id)
      end
    end
  end
end
