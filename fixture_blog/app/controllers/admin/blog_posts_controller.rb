class Admin::BlogPostsController < Admin::BaseController
  before_filter :build_blog_post, :only => [:new, :create]
  before_filter :load_blog_post, :only => [:edit, :update, :destroy]

  def index
    @blog_posts = BlogPost.all
  end

  def new
  end
  
  def create
    @blog_post.save!
    flash[:notice] = 'Blog Post Created'
    redirect_to :action => :index
  rescue ActiveRecord::RecordInvalid
    render :action => :new
  end

  def edit
  end

  def update
    @blog_post.update_attributes!(params[:blog_post])
    redirect_to :action => :edit
  rescue ActiveRecord::RecordInvalid
    render :action => :edit
  end

  def destroy
    @blog_post.destroy
    flash[:notice] = 'Blog Post Deleted'
    redirect_to :action => :index
  end

private
  def build_blog_post
    @blog_post = BlogPost.new(params[:blog_post])
  end

  def load_blog_post
    @blog_post = BlogPost.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render :text => 'No Post with that Id', :status => :not_found
  end
end
