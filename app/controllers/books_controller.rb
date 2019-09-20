class BooksController < ApplicationController

  # ログイン済みユーザーのみアクセス許可
  before_action :authenticate_user!

  before_action :current_user_check, only: [:edit, :update, :destroy]

  def index
    @books = Book.all
    @book_new = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
  end

  def create
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    # 上２行はこの1行でもok
    # @book_new = current_user.books.new(book_params)
    if @book_new.save
      redirect_to book_path(@book_new), notice: 'Book was successfully created.'
    else
      # index.html.erbで@booksを使うので
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    if book.destroy
      redirect_to books_path, notice: 'Book was successfully destroyed.'
    else
      redirect_to book_path(book), notice: 'error destroyed.'
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  #URLに直接入力で他人の投稿の編集されるのを防ぐ
  def current_user_check
    book = Book.find(params[:id])
    if current_user != book.user
      redirect_to books_path
    end
  end

end
