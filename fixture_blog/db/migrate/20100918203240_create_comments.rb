class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :name
      t.text :content
      t.integer :parent_id
      t.string  :parent_type

      t.integer :blog_post_id

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
