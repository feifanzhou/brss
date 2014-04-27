class AddStatusAndTypeToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :status, :string
    add_column :appointments, :type, :string
  end
end
