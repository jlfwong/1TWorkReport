class AddUserIdToBlogPost < ActiveRecord::Migration
  def self.up
    add_column :blog_posts, :user_id, :integer
  end

  def self.down
  end
end
