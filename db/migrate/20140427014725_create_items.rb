class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :contract_id
      t.string :type
      t.string :description
      t.text :notes
      t.decimal :weight
      t.string :pallet

      t.timestamps
    end
  end
end
