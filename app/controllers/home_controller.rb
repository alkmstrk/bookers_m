class HomeController < ApplicationController

  before_action :signin_user_check

  # アクションが記述されていなくても、railsはアクション名と同じビューファイルを探して、レスポンスとしてビューを返してくれる
  # def top
  # end

  # def about
  # end

  private

	  def signin_user_check
	  	if user_signed_in?
	    	redirect_to user_path(current_user)
	    end
	    # ↑と同義。このくらいのif分なら1行でまとめるのも良いかもしれない
	    # redirect_to user_path(current_user) if user_signed_in?
	  end

end
