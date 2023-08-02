class AddTokenToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :token, :string, default: ''
    add_index :users, :token, unique: true
  end
end
