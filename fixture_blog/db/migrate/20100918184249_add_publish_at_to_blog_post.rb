class AddPublishAtToBlogPost < ActiveRecord::Migration
  def self.up
    add_column :blog_posts, :publish_at, :datetime
  end

  def self.down
    remove_column :blog_posts, :publish_at
  end
end
