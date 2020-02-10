class FavoritesController < ApplicationController
  before_action :set_book

  def create
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
    # 遷移元にリダイレクト
    # redirect_back(fallback_location: root_path)
  end

  def destroy
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    # redirect_back(fallback_location: root_path)
  end

  def set_book
    @book = Book.find(params[:book_id])
  end

end
