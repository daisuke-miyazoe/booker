class BooksController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @user = current_user
        @book = Book.new
        @books = Book.all
    end
    def create
        @book = Book.new(book_params)
        @book.user_id = current_user.id
        if @book.save
            flash[:notice] = "You have created book successfully."
            redirect_to book_path(@book.id)
        else
            @user = User.find(current_user.id)
            @books = Book.all
            render :index
        end
    end
    def new
    end
    def show
        @book = Book.new
        @book_book = Book.find(params[:id])
        @user = @book_book.user
    end
    def edit
        @book = Book.find(params[:id])
        if @book.user != current_user
            redirect_to books_path
        end
    end
    def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
            flash[:notice] = "You have updated book successfully."
            redirect_to book_path(@book.id)
        else
            render :edit
        end
    end
    def destroy
        @book = Book.find(params[:id])
        if @book.user != current_user
            redirect_to books_path
        else @book.destroy
            redirect_to books_path
        end
    end

    private
    def book_params
        params.require(:book).permit(:title, :body)
    end
end
