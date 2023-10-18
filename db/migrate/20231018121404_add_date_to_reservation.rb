class AddDateToReservation < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :reservation_for, :date
  end
end
