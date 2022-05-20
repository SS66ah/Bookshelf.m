class CommentsController < ApplicationController
    before_action :authenticate_user!

        def create
            book = Book.find(params[:book_id])
            comment = book.comments.build(comment_params) #buildを使い、contentとbook_idの二つを同時に代入
            comment.user_id = current_user.id
            if comment.save
                flash[:success] = "コメントしました"
                redirect_back(fallback_location: root_path)
            else
                flash[:success] = "コメントできませんでした"
                redirect_back(fallback_location: root_path)
            end
        end

        private
            def comment_params
                params.require(:comment).permit(:content)
            end
end
