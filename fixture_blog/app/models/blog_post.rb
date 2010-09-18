class BlogPost < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :as => :parent
  has_many :all_comments, :class_name => 'Comment'

  validates :user,    :presence   => true
  validates :title,   :length     => 5..25
  validates :content, :presence   => true

  scope :published, where('publish_at <= ?', Time.zone.now.to_s(:db))
end
