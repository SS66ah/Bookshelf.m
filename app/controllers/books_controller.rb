class BooksController < ApplicationController
    def index
        @books = Book.all
    end

    #新規登録
    def new
        @book = Book.new
    end

    #新規登録
    def create
        book = Book.new(book_params)

        #bookをデータベースに保存し、saveが成功
        if book.save 
            redirect_to :action => "index" 
        #saveが失敗
        else
            redirect_to :action => "new"
        end
    end

    #詳細
    def show
        @book = Book.find(params[:id])
    end

    private
        def book_params
            params.require(:book).permit(:title, :author, :publisher, :year, :isbn,)
        end

end
