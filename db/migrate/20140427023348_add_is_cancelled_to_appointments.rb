class AddIsCancelledToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :is_cancelled, :boolean
  end
end
