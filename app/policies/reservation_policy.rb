class ReservationPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.bus_owner?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end
end
