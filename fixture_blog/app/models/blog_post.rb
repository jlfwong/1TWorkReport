class BlogPost < ActiveRecord::Base
  belongs_to :user

  validates :user,    :presence   => true
  validates :title,   :length     => 5..25
  validates :content, :presence   => true
end
