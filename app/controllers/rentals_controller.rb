class RentalsController < ApplicationController
    #貸出
    def create
        #book_idに本のid、user_idにログイン中のユーザーid
        rental = Rental.new(book_id: params[:id], user_id:current_user.id)
        #rentalをデータベースに保存し、saveが成功
        if rental.save
            redirect_to books_path, notice '貸出処理完了'
        #saveに失敗
        else
            redirect_to books_path, notice '貸出処理失敗'
    end
    
    #返却
    def update
        rental = Rental.find(params[:id])
        #returnedをtrueにする
        rental.update(returned: true)
        redirect_to books_path, notice '返却処理完了'
    end
end
