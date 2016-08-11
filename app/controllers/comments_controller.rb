class CommentsController < ApplicationController
	 before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

def create
	@post = Post.find(params[:post_id])
	@comment = @post.comments.create(comment_params)
	@comment.user = current_user
	if @comment.save 
		redirect_to @post
	else
		render 'new'
	end
end

def destroy
	 @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
	respond_to do |format|
      format.html { redirect_to :back, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
	
end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:post_id, :content, :user_id)
    end
end
