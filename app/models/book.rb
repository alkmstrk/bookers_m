class Book < ApplicationRecord
   belongs_to :user
   has_many :favorites, dependent: :destroy
   has_many :comments, dependent: :destroy
 
   validates :title, length: { minimum: 1 }
   validates :body, length: { in: 1..200 }

   def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
   end

 end
