class UsersController < ApplicationController

  # ログイン済みユーザーのみアクセス許可
  before_action :authenticate_user!

  before_action :current_user_check, only: [:edit, :update]

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
    # 下の二行は同義。今回はview側で直接、@user.booksと書いているので、コントローラーでインスタンス変数を定義する必要はない。説明のための記述。
    # @books = Book.where(user_id: @user.id)# booksテーブルからuser_idカラムの値と、@userのidが一致しているデータをすべて取得している。
    # @books = @user.books
  end

  # current_user_checkで@book = User.find(params[:id]) を定義しているのでeditアクション、updateアクションの@user= User.find(params[:id])は必要ない。
  # def edit
    # @user = User.find(params[:id])
  # end

  # renderでeditを呼び出し、エラー文を表示させるためにインスタンス変数に
  def update
    # @user = User.find(params[:id])
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
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to user_path(current_user)
    end
  end
end
