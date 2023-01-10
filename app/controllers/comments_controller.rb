class CommentsController < ApplicationController
    before_action :authenticate_user!

        def create
            book = Book.find(params[:book_id])
            #buildを使い、contentとbook_idの二つを同時に代入            
            comment = book.comments.build(comment_params)
            #user_idカラムにコメントした人のidを格納
            #取得したコメントのレコードのuser_idカラム＝現在ログインしているuserのid
            comment.user_id = current_user.id
            if comment.save
                flash[:success] = "コメントしました"
                redirect_back(fallback_location: root_path)
            else
                flash[:danger] = "コメントできません"
                redirect_back(fallback_location: root_path)
            end
        end

        private
            def comment_params
                params.require(:comment).permit(:content)
            end
end
