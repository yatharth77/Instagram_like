class CommentsController < ApplicationController
	before_action :set_post

	# def create
	#   @comment = @post.comments.build(comment_params)
	#   @comment.user_id = current_user.id

	#   if @comment.save
	#     flash[:success] = "You commented the hell out of that post!"
	#     redirect_back fallback_location: root_path
	#   else
	#     flash[:alert] = "Check the comment form, something went horribly wrong."
	#     render root_path
	#   end
	# end

	def create
	    @comment = @post.comments.build(comment_params)
	    @comment.user_id = current_user.id
	    
	    if @comment.save
	    	# logger.info "Processing the request..."
	      respond_to do |format|
	        format.html { redirect_to root_path }
	        format.js
	      end
	    else
	      flash[:alert] = "Check the comment form, something went wrong."
	      render root_path
	    end
	 end

	def destroy
	    @comment = @post.comments.find(params[:id])

	    if @comment.user_id == current_user.id
	      @comment.delete
	      respond_to do |format|
	        format.html { redirect_to root_path }
	        format.js
	      end
	    end
	end
	
	private

	def comment_params
	  params.require(:comment).permit(:content)
	end

	def set_post
	  @post = Post.find(params[:post_id])
	end
end
