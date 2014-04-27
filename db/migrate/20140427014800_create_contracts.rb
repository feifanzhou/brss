class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.integer :user_id
      t.string :contract_id
      t.string :type

      t.timestamps
    end
  end
end
