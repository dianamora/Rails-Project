class ReviewsController < ApplicationController
    before_action :redirect_if_not_logged_in

    def new 
        @user = User.find_by_id(params[:user_id])
        if params[:user_id] && @user 
            @review = @user.reviews.build
        else
        @review = Review.new
        end
    end

    def create 
        @review = current_user.reviews.build(review_params)
        if @review.save
            redirect_to reviews_path
        else
            render :new
        end
    end


    def index
        @user = User.find_by_id(params[:user_id])
        if params[:user_id] && @user == current_user
            @reviews = @user.reviews.published
        else
            @error = "User did not write this review" if params[:user_id]
            @reviews = Review.all.published
        end
    end

    def show
        @review = Review.find_by_id(params[:id])
        redirect_to reviews_path if !@review
    end

    def edit 
        @review = Review.find_by_id(params[:id])
        if current_user != @review.user
            redirect_to '/reviews'
        end
    end

    def update
        @review = Review.find_by_id(params[:id])
        
        if @review.update(review_params)
            redirect_to reviews_path
        else
            render :edit
        end
    end

    def destroy
        @review = Review.find_by_id(params[:id])
        @review.destroy
        redirect_to reviews_path
    end

    def top_reviewer
        # @user = current_user
        # @reviews = @user.reviews.most_reviews
    end

    private

    def review_params
        params.require(:review).permit(:title, :content)
    end
end
