Factory.define :blog_post do |f|
  f.association :user
  f.title       'MyString'
  f.content     'MyText'
end
