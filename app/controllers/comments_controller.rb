class CommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.comments.new(params.require(:comment).permit(:comment))
    @comment.book_id = @book.id
    @comment.save
  end

  def destroy
    comment = Comment.find(params[:book_id])
    @book = comment.book
    # comment = current_user.comments.find_by(book_id: @book.id)
    @comment_id = comment.id
    comment.destroy
  end

end
