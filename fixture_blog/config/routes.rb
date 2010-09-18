WorkreportBlog::Application.routes.draw do
  match '/admin' => 'admin#index'
  namespace :admin do
    resources 'posts', :controller => 'blog_posts', :as => 'blog_post', :except => [:show]
  end

  resources 'posts', :controller => 'blog_posts', :as => 'blog_post', :only => [:index,:show] do
    resources 'comments', :only => [:new]
  end

  resources 'comments', :only => [:create, :new] do
    member do
      get :reply, :to => :new
    end
  end
  root :to => redirect('/posts')
end
