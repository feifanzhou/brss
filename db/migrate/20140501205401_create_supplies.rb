class CreateSupplies < ActiveRecord::Migration
  def change
    create_table :supplies do |t|
      t.integer :appointment_id
      t.string :description
      t.integer :count

      t.timestamps
    end
  end
end
