class User < ApplicationRecord
    has_many :reviews
    has_many :comments
    has_many :commented_reviews, through: :comments, source: :review
    #we need to set to source this because 'commented_reviews' will look for this in the comment 
    #model but won't find it, raising an error
    has_secure_password #authenticate, validates pw

    validates :username, :email, presence: true

    # has_many :categories, through: :reviews

    def self.create_from_omniauth(auth)
        self.find_or_create_by(uid: auth['uid'], provider: auth['provider']) do |u|
            if u.username != auth['info']['name']
                hash = {username: auth['info']['name'], email: auth['info']['email'], password: SecureRandom.hex(16)}
                u.update(hash)
            end 
        end
    end

  
end
