class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ph_number, :string
    add_column :users, :address, :string
  end
end
