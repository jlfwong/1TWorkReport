class BlogPost < ActiveRecord::Base
  validates :title,   :length => 5..25
  validates :content, :presence => true
end
