class UsersController < ApplicationController

  # ログイン済みユーザーのみアクセス許可
  before_action :authenticate_user!

  before_action :current_user_check, only: [:edit, :update]

  def index
    @users = User.all
    @book_new = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book_new = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  # renderでeditを呼び出し、エラー文を表示させるためにインスタンス変数に
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'successfully updated.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  #URLに直接入力で編集を防ぐ
  def current_user_check
    user = User.find(params[:id])
    if current_user != user
      redirect_to user_path(current_user)
    end
  end

end
