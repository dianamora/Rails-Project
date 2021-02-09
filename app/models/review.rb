class Review < ApplicationRecord
  belongs_to :user
  # belongs_to :category
  has_many :comments
  has_many :users, through: :comments

  validates :content, :title, presence: true 


scope :alpha, -> { order(:title) }
scope :most_comments, -> {left_joins(:comments).group('posts.id').order('count
(comments.review_id)desc')}


end

#Create a new page where the user who's left the most reviews is displayed
#show the user's name "our top contributor and the number of reviews"
#scope method will go here