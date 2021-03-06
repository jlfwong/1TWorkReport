class Comment < ActiveRecord::Base
  belongs_to :parent, :polymorphic => true
  belongs_to :blog_post
  has_many :replies, :class_name => 'Comment', :as => :parent
  validates :name,  :length   => 4..25,
                    :format   => /\A[A-Za-z0-9\-_ ]*\Z/
  validates :parent, :presence => true
  validates :content, :length => 1..400
  validates :blog_post, :presence => true

  validate :validates_parent

  before_validation :set_blog_post_id
private
  def validates_parent
    return if parent.nil? || (parent.class.name == self.class.name)
    unless parent.publish_at && parent.publish_at <= Time.zone.now
      errors.add(:parent,"Post must be published to comment") 
    end

    if self.parent == self
      errors.add(:parent,"Parent cannot be self")
    end
  end

  def set_blog_post_id
    return if self.parent.nil?

    if self.parent.is_a? BlogPost
      self.blog_post = self.parent
    elsif self.parent.is_a? Comment
      self.blog_post = self.parent.blog_post
    end
  end
end
