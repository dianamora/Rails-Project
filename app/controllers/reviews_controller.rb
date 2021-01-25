class ReviewsController < ApplicationController
    before_action :redirect_if_not_logged_in

    def new 
        if params[:user_id] && @user = User.find_by_id(params[:user_id])
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
        if params[:user_id] && @user = User.find_by_id(params[:user_id])
        @review = @user.reviews
        else
            flash[:message] = "That review doesn't exist"
            @reviews = Review.all
        end

    end

    def show
        @review = Review.find_by_id(params[:id])
        redirect_to reviews_path if !@review
    end

    def edit 
        @review = Review.find_by_id(params[:id])
    end

    def update
        @review = Review.find_by_id(params[:id])
        @review.update(review_params)
        if @review.valid?
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
    private

    def review_params
        params.require(:review).permit(:title, :content)
    end
end
