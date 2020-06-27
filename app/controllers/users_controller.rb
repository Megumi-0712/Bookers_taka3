class UsersController < ApplicationController

    before_action :authenticate_user!
    before_action :correct_user, only: [:edit, :update]

    def index
        @users = User.all
    end

    def new
        @user = User.new
    end

	def show
        @user = User.find(params[:id])
        @book = Book.new
        @books = @user.books
    end

    def create
        @user = User.create(user_params)
        if @user.save
            flash[:notice] = "Welcome! You have signed up successfully."
            redirect_to user_path(@user.id)
        else
            flash.now[:error]
            render :new
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
    	@user = User.find(params[:id])

        if current_user == @user

    	   if @user.update!(user_params)
                flash[:notice] = "You have updated user successfully."
                redirect_to user_path(@user.id)
            else
                flash.now[:error]
                render :edit
            end
        else
            redirect_to root_url
        end
    end

    private
    def user_params
    	params.require(:user).permit(:name, :profile_image, :introduction)
    end

    def correct_user
        @user = User.find(params[:id])
        redirect_to(root_path) unless @user == current_user
    end
end