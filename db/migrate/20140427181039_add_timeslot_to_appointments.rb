class AddTimeslotToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :timeslot_number, :integer
    add_column :appointments, :timeslot_text, :string
  end
end
