# class PostsController < ApplicationController

# 	def index
# 		@posts = Post.all
# 	end

# 	def new
# 		@post = Post.new
# 	end

# 	def create
# 		@post = Post.create(post_params)
# 		redirect_to posts_path
# 	end

# 	def show
# 		@post = Post.find(params[:id])
# 	end

# 	def edit
# 		@post = Post.find(params[:id])
# 	end

# 	def update
# 		@post = Post.find(params[:id])
# 		@post.update(post_params)
#   		redirect_to(post_path(@post))
# 	end

# 	def destroy
# 		@post = Post.find(params[:id])
# 		@post.destroy
#   		redirect_to posts_path
# 	end

# 	private

# 		def post_params
# 		  params.require(:post).permit(:image, :caption)
# 		end
# end

class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!
	before_action :owned_post, only: [:edit, :update, :destroy]
	
	def user_profile
		@this_user_post = Post.where(user_id: params[:id]).order(created_at: :desc).paginate(page:  params[:page], per_page: 2)
		if @this_user_post.empty?
			flash[:alert] = "No such user"
			redirect_back fallback_location: root_path
		end
	end

	def index
		@posts = Post.all.order(created_at: :desc).paginate(page:  params[:page], per_page: 2)
	end

	def show

	end

	def new
    	@post = current_user.posts.build
 	end

	def create
		@post = current_user.posts.build(post_params)
	    if @post.save
	      flash[:success] = "Your post has been created!"
	      redirect_to posts_path
	    else
	      flash[:alert] = "Your new post couldn't be created!  Please check the form."
	      render :new
	    end
	end

	def edit

	end

	def update
	    if @post.update(post_params)
	      flash[:success] = "Post updated."
	      redirect_to posts_path
	    else
	      flash.now[:alert] = "Update failed.  Please check the form."
	      render :edit
	    end
	end

	def destroy
		@post.destroy
		redirect_to root_path
	end

	private

	def post_params
		params.require(:post).permit(:image, :caption)
	end

	def set_post
		@post = Post.find(params[:id])
	end

	def owned_post
	  unless current_user == @post.user
	    flash[:alert] = "That post doesn't belong to you!"
	    redirect_to root_path
	  end
	end
	
end