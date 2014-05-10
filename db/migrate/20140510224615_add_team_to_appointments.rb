class AddTeamToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :team, :string
  end
end
