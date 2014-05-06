class AddFieldRepNameToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :rep_name, :string
  end
end
