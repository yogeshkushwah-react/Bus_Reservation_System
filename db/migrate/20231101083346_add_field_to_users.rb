class AddFieldToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :full_name, :string
    add_column :users, :phone_no, :string
    add_column :users, :address, :string
  end
end
