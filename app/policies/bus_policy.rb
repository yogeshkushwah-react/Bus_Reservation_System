class BusPolicy < ApplicationPolicy
  def update?
    user.bus_owner?
  end

  def create?
    user.bus_owner?
  end

  def destroy?
    user.bus_owner?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user&.bus_owner? || user&.admin?
        scope.all
      else
        scope.approved
      end
    end
  end
end
