class CreateAnalytics < ActiveRecord::Migration
  def change
    create_table :analytics do |t|
      t.string :provision
      t.integer :appointment_id
      t.string :value

      t.timestamps
    end
  end
end
