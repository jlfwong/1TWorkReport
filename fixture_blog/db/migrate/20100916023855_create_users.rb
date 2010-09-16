class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :password
    end

    add_index :users, [:username, :password]
  end

  def self.down
    drop_table :users
  end
end
