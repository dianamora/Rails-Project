class CommentsController < ApplicationController
    before_action :redirect_if_not_logged_in

def index
    @review = Review.find_by_id(params[:review_id])
    if params[:review_id] && @review  #if it's nested...do the following:
        @comments = @review.comments
    else
        @error = "Sorry, no review found." if params[:review_id]
        @comments = Comment.all
     end
end

def new
    @review = Review.find_by_id(params[:review_id])
    if params[:review_id] && @review
         @comment = @review.comments.build
    else
        @error = "Review not found" if !params[:review_id]
        @comment = Comment.new
    end
end

def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
        redirect_to reviews_path(@review)
    else
        render :new
    end
end

def show
    @comment = Comment.find_by(id: params[:id])
  
end

# def edit
#     @comment = Comment.find_by(id: params[:id])
# end

def update
    @comment = Comment.find_by(id: params[:id])
    if @comment.update(comment_params)
        redirect_to comment_path(@comment)
    else
        render :edit
    end
    
end

def destroy
    @comment = Comment.find_by_id(params[:id])
    @comment.destroy
    redirect_to reviews_path
end

private

    def comment_params
        params.require(:comment).permit(:content, :review_id, :user_id)
    end

end
