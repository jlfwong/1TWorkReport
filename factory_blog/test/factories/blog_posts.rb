Factory.define :blog_post do |f|
  f.association :user
  f.title       'MyString'
  f.content     'MyText'
end

Factory.define :published_blog_post, :parent => :blog_post do |f|
  f.publish_at  7.days.ago
end

Factory.define :unpublished_blog_post, :parent => :blog_post do |f|
  f.publish_at  7.days.from_now
end
