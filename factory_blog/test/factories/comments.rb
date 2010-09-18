Factory.define :comment do |f|
  f.name      'Default Comment Name'
  f.content   'Default Comment Text'
  f.association :parent, :factory => :published_blog_post
end

Factory.define :comment_reply, :parent => :comment do |f|
  f.name      'Default Reply Name'
  f.content   'Default Reply Text'
  f.association :parent, :factory => :comment
end
