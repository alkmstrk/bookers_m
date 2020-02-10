class ApplicationRecord < ActiveRecord::Base
	self.abstract_class = true

	def self.search(search, user_or_book)
		if user_or_book == "1" && search != ""
			Book.where(['title LIKE ?', "%#{search}%"])
		elsif user_or_book == "2" && search != ""
			User.where(['name LIKE ?', "%#{search}%"])
    end
	end
	
end
