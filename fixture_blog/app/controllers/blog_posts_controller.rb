class BlogPostsController < ApplicationController
  def index
    @blog_posts = BlogPost.published
  end

  def show
    @blog_post = BlogPost.published.find(params[:id])
    @comments = BlogPost.published
  rescue ActiveRecord::RecordNotFound
    render :text => 'No Post with that Id', :status => :not_found
  end
end
