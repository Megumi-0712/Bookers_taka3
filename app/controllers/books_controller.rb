class BooksController < ApplicationController
	before_action :authenticate_user!
  before_action :current_user, only: [:edit, :update, :destroy]

	def new
    @book = Book.new
    @books = Book.all
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
      if @book.save
		    flash[:notice] = "You have creatad book successfully."
		    redirect_to book_path(@book)
      else
        @books = Book.all
        @user = current_user
  		  render :index
      end
  end

  def show
    @book = Book.find_by(id: params[:id])
    @book_new = Book.new
    @user = @book.user
  end

  def edit
    @book = Book.find_by(id: params[:id])
  end

  def update
    @book = Book.find_by(id: params[:id])
      if @book.update(book_params)
        flash[:notice] = "You have updated book successfully."
        redirect_to user_path(@book.id)
      else
        render :edit
      end
  end

  def destroy
    book = Book.find_by(id: params[:id])
    book.destroy
    redirect_to books_path
  end

  private
    def book_params
      params.require(:book).permit(:title, :body)
    end

    def corrent_user
      @book = Book.find(params[:id])
      @user = @book.user
        redirect_to books_path unless @user == current_user
    end
end