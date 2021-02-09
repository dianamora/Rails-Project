class Review < ApplicationRecord
  belongs_to :user
  # belongs_to :category
  has_many :comments
  has_many :users, through: :comments

  validates :content, :title, presence: true 
 
scope :alpha, -> { order(:title) }
scope :published, -> { order('created_at desc')}



#Create a new page where the user who's left the most reviews is displayed
#show the user's name "our top contributor and the number of reviews"
#scope method will go here
scope :most_reviews, -> {left_joins(:reviews).group('users.id').order('count
(reviews.user_id)desc')}




end

