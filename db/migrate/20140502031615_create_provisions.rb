class CreateProvisions < ActiveRecord::Migration
  def change
    create_table :provisions do |t|
      t.string :code
      t.string :description
      t.integer :user_id
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
