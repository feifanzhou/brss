class AddDataToUsers < ActiveRecord::Migration
  def change
    add_column :users, :net_id, :string
    add_column :users, :gender, :string, limit: 1
    add_column :users, :school, :string
    add_column :users, :major, :string
    add_column :users, :grad_year, :string, limit: 4
    add_column :users, :dob, :date
    add_column :users, :is_international, :boolean
    add_column :users, :should_spam, :boolean
  end
end
