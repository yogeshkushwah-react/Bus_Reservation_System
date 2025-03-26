class BusownersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    authorize @user
    render layout: "profile"
  end

  def index
    authorize User
    @bus_owners = User.bus_owner
  end

  def bus_owner_buses
    authorize User
    @buses = Bus.where(bus_owner_id: params[:id])
    render "buses/index"
  end
end
