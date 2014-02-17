class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :fname
      t.string :lname
      t.string :password_digest
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state, limit: 2
      t.string :remember_token
      t.string :zip
      t.string :phone
      t.string :country
      t.boolean :is_rep
      t.boolean :is_admin
      t.boolean :is_active

      t.timestamps
    end
  end
end
