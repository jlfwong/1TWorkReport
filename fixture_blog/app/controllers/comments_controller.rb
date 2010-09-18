class CommentsController < ApplicationController
  def new
    @comment = Comment.new(params[:comment])

    if params[:id].present?
      @comment.parent = Comment.find(params[:id])
      @comment.blog_post = @comment.parent.blog_post
    else
      blog_post = BlogPost.find(params[:blog_post_id])
      @comment.blog_post = blog_post
      @comment.parent = blog_post
    end
  end

  def create
    @comment = Comment.new(params[:comment])
    @comment.save!  
    redirect_to blog_post_path(@comment.blog_post)
  rescue ActiveRecord::RecordInvalid
    render :action => :new
  end
end
