class PostsController < ApplicationController
    before_action :authenticate_user!, only: %i[new edit create update destroy]
    #before_action :set_post, only: %i[show edit update destroy]
   

    def index
        @posts = Post.ordered.with_authors
    end

    def show 
        @post = Post.find(params[:id])
    end

    def new
        @post = Post.new()
    end

    def create
        @post = Post.new(post_params)
        @post.author = current_user
        
        if @post.save
            flash[:success]="Post was successfully created"
            redirect_to @post
        else
            flash[:success]="Failed to create a new post"
            render :new
        end
    end
    
    def edit
        @post = Post.find(params[:id]) 
    end

    def update
        @post = Post.find(params[:id]) 

        if @post.update(post_params)
            flash[:success]="Post was successfully updated"
            redirect_to @post
        else
            flash[:success]="Post was not updated"
            render :edit
        end
    end
    
    def destroy
        @post=Post.find(params[:id])
        @post.destroy
        flash[:success]="Post was deleted"
        redirect_to root_path
    end

    private 

    def post_params
        params.require(:post).permit(:title, :body)
    end
end