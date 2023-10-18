class CreateBuses < ActiveRecord::Migration[7.0]
  def change
    create_table :buses do |t|
      t.string :name
      t.string :registration_no
      t.string :source_route
      t.string :destination_route
      t.integer :no_of_seats
      t.integer :status
      t.references :bus_owner, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
