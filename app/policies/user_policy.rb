class UserPolicy < ApplicationPolicy
  def show?
    user.admin?
  end

  def bus_owner_list?
    user.admin?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
