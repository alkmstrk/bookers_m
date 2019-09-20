class HomeController < ApplicationController

  before_action :signin_user_check

# コントローラーにtopアクションがなくてもrailsが予測してtop.html.erbを返してくれる
  # def top
  # end

  # def about
  # end

  private
  # ログインしているユーザーは入れないように
  def signin_user_check
    if user_signed_in?
      redirect_to user_path(current_user)
    end
  end
end
