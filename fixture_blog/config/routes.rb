WorkreportBlog::Application.routes.draw do
  match '/admin' => 'admin#index'
  namespace :admin do
    resources 'posts', :controller => 'blog_posts', :as => 'blog_post', :except => [:show]
  end

  resources 'posts', :controller => 'blog_posts', :as => 'blog_post', :only => [:index,:show]
  root :to => redirect('/posts')
end
