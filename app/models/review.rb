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