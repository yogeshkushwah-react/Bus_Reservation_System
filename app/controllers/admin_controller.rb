class AdminController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    authorize @user, :admin?
    render layout: "profile"
  end

  def approve_bus
    authorize User
    @bus = Bus.find(params[:id])
    @bus.approved!
    render "buses/show"
  end

  def reject_bus
    authorize User
    @bus = Bus.find(params[:id])
    @bus.rejected!
    render "buses/show"
  end
end
