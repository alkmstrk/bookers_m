class Book < ApplicationRecord

 # Bookモデルを経由して、Userモデルの情報を取ってきている
  belongs_to :user

	#これでも正常に動く(〇〇.userが使える)。アソシエーションを宣言することで、このメソッドも追加される。
	#selfは呼び出し元の〇〇.userの〇〇にあたる。book.userならbook。selfは,そのクラスのインスタンス変数の参照に利用される。
  # def user
  # 	User.find(self.user_id)
  # end

  validates :title, length: { minimum: 1 }
  validates :body, length: { in: 1..200 }
end
