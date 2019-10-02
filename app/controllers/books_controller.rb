class BooksController < ApplicationController

  # before_action 指定したコードを各アクションが動く前に実行させることができる。

  # ログイン済みユーザーのみアクセス許可
  before_action :authenticate_user!

  # edit,update,destroyだけにcurrent_user_checkを呼び出している
  before_action :current_user_check, only: [:edit, :update, :destroy]

  def index
    @books = Book.all
    @book_new = Book.new
    # render :index
  end

  def show
    # paramsはパラメーター(フォームから送られてきた値、urlに入っている値(:id))を受け取るためのメソッド(ターミナルを見ればパラメーターに何が入っているかわかる)
    @book = Book.find(params[:id])
    @book_new = Book.new
    # 下の二行は同義。Bookers300ではview側で直接@book.userと書いているので、コントローラーでインスタンス変数を定義する必要はない。説明のための記述。
    # @user = User.find(@book.user_id) # usersテーブルからuserのidと@bookのuser_idカラムの値が一致しているものを一件取得
    # @user = @book.user
  end

  def create
    # index.html.erbで@book_newを使うのでインスタンス変数にする
    @book_new = Book.new(book_params)
    # @book_newのuser_idカラムに値を代入する必要がある
    @book_new.user_id = current_user.id
    # 上２行はこの1行でもok
    # @book_new = current_user.books.new(book_params)
    if @book_new.save
      redirect_to book_path(@book_new), notice: 'Book was successfully created.'
    else
      # index.html.erbで@booksを使うので
      @books = Book.all
      # @bookは定義し直してはいけない。
      render :index
    end
  end

  # current_user_checkで@book = Book.find(params[:id]) を定義しているのでeditアクション、updateアクションのdestroyアクションの@book = Book.find(params[:id])は必要ない
  # イメージとしてはeditアクション,updateアクション、destroyアクションがそれぞれcurrent_user_ceckメソッドが合体してる感じ。↓のupdateアクションみたいに
  # def update
  #   @book = Book.find(params[:id])
  #   if current_user != @book.user
  #     redirect_to books_path
  #   end

  #   @book = Book.find(params[:id])
  #   if @book.update(book_params)
  #     redirect_to book_path(@book), notice: 'Book was successfully updated.'
  #   else
  #     render :edit
  #   end
  # end

# editアクションを記述する必要さえない。railsがeditアクションを探した段階でcurrent_user_checkが呼び出される、editアクションが記述されてなくても、railsが予測してview(edit.html.erb)を返す。
  # def edit
    # @book = Book.find(params[:id])
  # end

  def update
    # @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    # @book = Book.find(params[:id])
    if @book.destroy
      redirect_to books_path, notice: 'Book was successfully destroyed.'
    else
      redirect_to book_path(@book), notice: 'error destroyed.'
    end
  end

  private


  def book_params
    params.require(:book).permit(:title, :body)
  end

  #URLに直接入力で他人の投稿の編集されるのを防ぐ
  def current_user_check
    @book = Book.find(params[:id])
    # もしログインしているユーザーとその本を投稿した人が一致しない場合
    if current_user != @book.user
      redirect_to books_path
    end
  end

end
