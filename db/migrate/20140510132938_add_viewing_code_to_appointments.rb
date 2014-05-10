class AddViewingCodeToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :viewing_code, :string
  end
end
