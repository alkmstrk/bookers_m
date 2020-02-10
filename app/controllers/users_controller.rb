class UsersController < ApplicationController

  # ログイン済みユーザーのみアクセス許可
  before_action :authenticate_user!

  before_action :current_user_check, only: [:edit, :update]

  def mail
    unless current_user.mail_check
      UserMailer.welcome_email(current_user).deliver_now
    end
    redirect_to user_path(current_user)
  end

  def welcome
    @user = User.find(params[:id])
    @user.mail_check = true
    @user.save
  end

  def index
    @users = User.all
    @book_new = Book.new
    # render :index
    # renderメソッドはユーザーへのレスポンスとして送信すべき内容を指定している。(http://localhost:3000/usersというリクエストに対してbooks/index.html.erbを返している)
    # railsはレスポンスとして送信すべき内容を指定していない場合、アクション名と同じ名前のviewを返す。なのでrender :indexとかく必要はない。render :indexが省略されているとも言える。
    # 他のアクションでも同じ。
  end

  def show
    @user = User.find(params[:id])
    @book_new = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'successfully updated.'
    else
      render :edit
    end
  end

  def following
    @title = "フォロー"
    @user = User.find(params[:id])
    @book = Book.new
    @users = @user.following_user.all
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user = User.find(params[:id])
    @book = Book.new
    @users = @user.follower_user.all
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :postcode, :prefecture_name, :address_city, :address_street, :address_building)
  end

  def current_user_check
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to user_path(current_user)
    end
  end
end
