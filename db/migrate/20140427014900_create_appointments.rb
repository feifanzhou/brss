class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.string :appointment_id
      t.date :date
      t.integer :insurance_cost
      t.string :address
      t.text :notes
      t.boolean :on_campus
      t.date :request_date
      t.string :coupon_code
      t.boolean :price_match
      t.string :referrer
      t.boolean :pre_arrival
      t.string :pre_arrival_address
      t.integer :contract_id
      t.boolean :at_counter
      t.date :term_ends
      t.integer :term_count

      t.timestamps
    end
  end
end
