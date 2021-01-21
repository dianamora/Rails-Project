class User < ApplicationRecord
    has_many :reviews
    has_many :comments
    has_many :commented_reviews, through: :comments,
        source: :review
    #we need to set to source this because 'commented_reviews' will look for this in the comment 
    #model but won't find it, raising an error

    # has_many :categories, through: :reviews

end
