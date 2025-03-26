class BusesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :set_bus, except: [:index, :new, :create, :search]

  def index
    @buses = policy_scope(Bus)
  end

  def show
  end

  def new
    @bus = Bus.new
    authorize @bus
  end

  def create
    authorize Bus
    @bus = Bus.new(bus_params)
    @bus.bus_owner = current_user
    if @bus.save
      redirect_to buses_path, notice: "Bus added successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @bus
    @bus.destroy
    redirect_to buses_path, status: :see_other, alert: "Bus deleted successfully!"
  end

  def edit
  end

  def update
    authorize @bus
    if @bus.update(bus_params)
      redirect_to bus_path, notice: "Bus edited successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def search
    @buses = Bus.search(params[:query])
    render :index
  end

  private

  def set_bus
    @bus = Bus.find(params[:id])
  end

  def bus_params
    params.require(:bus).permit(:name, :registration_no, :source_route, :destination_route, :no_of_seats, :main_image)
  end
end
