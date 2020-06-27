class BooksController < ApplicationController
	before_action :authenticate_user!,only: [:new,:edit, :destroy]

	def new
    @book = Book.new
    @books = Book.all
  end

  def index
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @books = Book.all
      if @book.save
		    flash[:notice] = "You have creatad book successfully."
		    redirect_to book_path(Book.last)
      else
        flash.now[:error]
  		  render :index
      end
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @books = Book.all
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
      if @book.update(book_params)
        flash[:notice] = "You have updated book successfully."
        redirect_user_path(@Book.id)
      else
        flash.now[:error]
        render :edit
      end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to book_path
  end

  private
    def book_params
      params.require(:book).permit(:title, :body)
    end
end