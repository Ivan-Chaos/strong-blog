class CommentsController < ApplicationController
    before_action :authenticate_user!, only: %i[new edit create update destroy]
  
    def create
      @post = Post.find(params[:post_id])
      @comment = @post.comments.create(comment_params)
      @comment.author=current_user
      @comment.save
    
      redirect_to post_path(@post)
    end

    def destroy
      @post = Post.find(params[:post_id])
      @comment=@post.comments.find(params[:id])
      @comment.author=current_user

      redirect_to post_path(@post)
    end

    private
      def comment_params
        params.require(:comment).permit(:commenter, :body, :status, :author)
      end
  end