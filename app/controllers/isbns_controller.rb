class IsbnsController < ApplicationController

    def new

    end
    
    def create
        load'openbdapi.erb'
        #response = OpenbdAPI.new(params[:isbn]).main
        res = OpenbdApiService.new
        response = res.execute(params[:isbn])
        #response = OpenbdApiService.new.execute(params[:isbn])
        #binding.pry

        #ISBNコードがないor適当な数字の時
        if response == [nil]
            redirect_to new_book_isbns_path, notice: 'ISBNコードが存在しません'
            return

        #ISBNコードがあるとき
        else
            if response[0]["summary"]["title"]
                title = response[0]["summary"]["title"]
            end

            if response[0]["summary"]["author"]
                author = response[0]["summary"]["author"]
            else
                author = nil
            end

            if response[0]["summary"]["publisher"]
                publisher = response[0]["summary"]["publisher"]
            else 
                publisher = nil
            end

            if response[0]["summary"]["isbn"]
                isbn = response[0]["summary"]["isbn"]
            else 
                isbn = nil
            end

            if response[0]["summary"]["pubdate"]
                pubdate = response[0]["summary"]["pubdate"]
            else 
                pubdate = nil
            end

            if response[0]["summary"]["cover"]
                image = response[0]["summary"]["cover"]
            else
                image = nil
            end

            
        
            @book = Book.new(
                            title: title,
                            author: author,
                            publisher: publisher,
                            year: pubdate,
                            isbn: isbn,
                            
                            )
            @book.user = current_user
            @book.remote_image_url = image

            #binding.pry

            if @book.save
                redirect_to new_book_isbns_path, notice: '書籍情報が正しく登録されました'
                
            else
                redirect_to new_book_isbns_path, notice: '同一の書籍が既に登録されています'
            end
        end
    end
end