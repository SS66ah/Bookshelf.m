class BooksController < ApplicationController

    before_action :authenticate_user!

    def index
        @books = Book.all.page(params[:page]).per(10)
    end

    #新規登録
    def new
        @book = Book.new
    end

    #新規登録
    def create
        #bookレコードに投稿内容を格納
        book = Book.new(book_params)

        #user_idカラムに投稿者のidを格納
        #取得したbookのレコードのuser_idカラム＝現在ログインしているuserのid
        book.user_id = current_user.id

        #データベースへの保存を行い遷移するページを指定
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

        @comments = @book.comments
        @comment = Comment.new
    end

    #編集
    def edit
        @book = Book.find(params[:id])
    end

    #削除
    def destroy
        book = Book.find(params[:id])
        book.destroy
        redirect_to action: :index
    end

    def update
        book = Book.find(params[:id])
        if book.update(book_params)
            redirect_to :action => "show", :id => book.id
        else
            redirect_to :action => "new"
        end
    end


    private
        def book_params
            params.require(:book).permit(:title, :author, :publisher, :year, :isbn,)
        end

end
