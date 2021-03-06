class PostsController < ApplicationController
    before_action :authenticate_user!, only: %i[new edit create update destroy]
    #before_action :set_post, only: %i[show edit update destroy]
   

    def index
        authorize Post
        @posts = Post.published("public", current_user).ordered.with_authors.all.paginate(page: params[:page], per_page: 20)
        
        @posts = @posts.search(params[:query])

    end

    def non_published
        authorize Post

        @posts = current_user.dungeonMaster? ? Post.all : current_user.posts
        @posts= @posts.non_published.ordered.with_authors.all.paginate(page: params[:page], per_page: 5)
    end

    def remove_image
        session[:return_to] ||= request.referer
        @post_file = ActiveStorage::Attachment.find(params[:format])
        @post_file.purge
        redirect_to session.delete(:return_to)  
    end

    def show 
        
        @post = Post.find(params[:id])
        authorize @post
    end

    def new
        authorize Post
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
        authorize @post
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
        authorize @post
        @post.destroy
        flash[:success]="Post was deleted"
        redirect_to root_path
    end

    private 

    def post_params
        params.require(:post).permit(:title, :body, :status, :file)
    end
end