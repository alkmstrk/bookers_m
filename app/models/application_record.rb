class ApplicationRecord < ActiveRecord::Base
	# Rails はそのクラス名に対応したデータベースのテーブルを自動的に探そうとする。Bookモデルならbooksテーブルを探す。
	# self.abstract_class = trueと書いていないと、application_recordsテーブルをさがしてしまう。
	# ↓は最初から記述されている
  self.abstract_class = true
end
