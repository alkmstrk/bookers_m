class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

# Userモデルを経由して、Bookモデルの情報を取ってきている
  has_many :books, dependent: :destroy

  # これでも正常に動く(〇〇.userが使える)。(dependent: :destroyは考慮していない)
  # def books
  # 	Book.where(user_id: self.id)
  # end

  validates :name,length: { in: 2..20 }
  validates :introduction, length: { maximum: 50}

  # refileのルールでprofile_image_idの_idを外して記述
  attachment :profile_image

end

