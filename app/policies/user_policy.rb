class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def bus_owner_buses?
    user.admin? || user.bus_owner?
  end

  def admin?
    user && user.admin?
  end

  def busowner?
    user && user.bus_owner?
  end

  def approve_bus?
    user.admin?
  end

  def reject_bus?
    user.admin?
  end

  def show?
    user && user.user?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
