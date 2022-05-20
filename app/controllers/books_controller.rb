class BooksController < ApplicationController
    def index
    end

    #新規登録
    def new
        @book = Book.new
    end

    #新規登録
    def create
        book = Book.new(book_params)

        book.user_id = current_user.id
        
        #bookをデータベースに保存し、saveが成功
        if book.save 
            redirect_to :action => "index" 
        #saveが失敗
        else
            redirect_to :action => "new"
        end
    end

end
