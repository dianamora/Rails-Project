class CommentsController < ApplicationController
    before_action :redirect_if_not_logged_in

def index
    if params[:review_id] && @review = Review.find_by_id(params[:review_id])
        @comments = @review.comments
    else
        flash[:message] = "Sorry, no review found."
        @comments = Comment.all
     end
    
end

def new
    if params[:review_id] && @review = Review.find_by_id(params[:post_id])
        @comment = @review.comments.build
    else
        flash[:message] = "Review not found" 
        @comment = Comment.new
    end
end

def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
        redirect_to comments_path
    else
        render :new
    end
end

def show
    @comment = Comment.find_by(id: params[:id])
end

def edit
    @comment = Comment.find_by(id: params[:id])
end

def update
    @comment = Comment.find_by(id: params[:id])
    if @comment.update(comment_params)
        redirect_to comment_path(@comment)
    else
        render :edit
    end
    
end

private

    def comment_params
        params.require(:comment).permit(:content, :post_id)
    end

end
