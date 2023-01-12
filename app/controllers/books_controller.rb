class BooksController < ApplicationController

    #ログイン済みかどうかを確認
    before_action :authenticate_user!

    def index
        
        if params[:search] == nil
            @books = Book.all.page(params[:page]).per(20).order("created_at DESC")
        elsif params[:search] == ''
            @books = Book.all.page(params[:page]).per(20).order("created_at DESC")
        else
            #部分検索
            @books = Book.where("title LIKE ? ",'%' + params[:search] + '%').page(params[:page]).per(20).order("created_at DESC")
        end
    end

    #新規登録
    def new
        #newアクション(新規登録)
        @book = Book.new
    end

    #新規登録
    def create
            #bookレコードに投稿内容を格納
            @book = Book.new(book_params)

            #user_idカラムに投稿者のidを格納
            #取得したbookのレコードのuser_idカラム＝現在ログインしているuserのid
            @book.user_id = current_user.id

            @book.isbn = @book.isbn.gsub(/-/, '')
            #binding.pry
            if
                Book.where(isbn:"#{@book.isbn}").count >= 1
                #binding.pry
                flash[:info] = "登録済みであるため登録できませんでした"
                redirect_to new_book_path
                return
            end

            #データベースへの保存を行い遷移するページを指定
            #bookをデータベースに保存し、saveが成功
            if @book.save 
                flash[:success] ="書籍情報が正しく登録されました"
                redirect_to new_book_path
            #saveが失敗
            else
                flash[:danger] ="正常に登録されませんでした"
                redirect_to new_book_path
            end
    end

    #詳細
    def show
        #@bookに、送られてきたidの登録情報を代入
        @book = Book.find(params[:id])
        #newアクション(コメント)
        @comment = Comment.new
        @comments = @book.comments

        if params[:search] == nil
            @books = Book.first(0)
        elsif params[:search] == ''
            @books = Book.first(0)
        else
            #部分検索
            @keyword = params[:search]
            @books = Book.where("content LIKE ? ",'%' + params[:search] + '%')
        end
    end

    #編集
    def edit
        @book = Book.find(params[:id])
    end

    #削除
    def destroy
        @book = Book.find(params[:id])
        #book変数の中に格納されている登録情報に対応するレコードを削除
        @book.destroy
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
            params.require(:book).permit(:title, :author, :publisher, :year, :isbn, :image,:content)
        end

end
