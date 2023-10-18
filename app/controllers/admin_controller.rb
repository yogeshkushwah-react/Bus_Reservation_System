class AdminController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    authorize @user
  end

  def bus_owner_list
    authorize User
    @bus_owner = User.bus_owner
  end

  def approve_bus
    authorize User
    @bus = Bus.params[:id]
    @bus.approved!
  end

  def reject_bus
    authorize User
    @bus = Bus.params[:id]
    @bus.rejected!
  end
end
