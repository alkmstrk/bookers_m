class SearchController < ApplicationController

  def index
    @book_new = Book.new
    @option = params[:option]
    @results = ApplicationRecord.search(params[:search], params[:option])
  end

end
