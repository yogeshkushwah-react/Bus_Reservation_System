class BusPolicy < ApplicationPolicy
  attr_reader :user, :bus

  def initialize(user, bus)
    @user = user
    @bus = bus
  end

  def update?
    user.bus_owner?
  end

  def edit?
    user.bus_owner? && bus.bus_owner == user
  end

  def create?
    user.bus_owner?
  end

  def destroy?
    user.bus_owner? && bus.bus_owner == user
  end

  def show?
    user && user.bus_owner? && bus.bus_owner == user
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user&.admin?
        scope.all
      elsif user&.bus_owner?
        Bus.approved.or(Bus.where(bus_owner_id: user.id))
      else
        scope.approved
      end
    end
  end
end
