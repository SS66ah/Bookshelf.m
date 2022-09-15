class IsbnsController < ApplicationController

    def new

    end
    
    def create
        #response = OpenbdAPI.new(params[:isbn]).main
        response = OpenbdApiService.new.execute(params[:isbn])
        
        return redirect_to new_book_isbns_path, notice: 'ISBNコードが存在しません' 

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

        if pubdate = response[0]["summary"]["cover"]
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
                        image: image
                        )
        @book.user = current_user

        if @book.save
            redirect_to new_book_isbns_path(@book), notice: '書籍情報が正しく登録されました'
            
        else
            redirect_to new_book_isbns_path, notice: '同一の書籍が既に登録されています'
            
        end
        
    end
end

class OpenbdApiService
    require 'net/http'
    require 'uri'
    require 'json'
    
    BASE_URL = 'https://api.openbd.jp/v1/get?isbn='

    def execute(isbn)
        
        @request_url = BASE_URL + isbn
        uri = URI.parse(@request_url)
        json = Net::HTTP.get(uri)
        response = JSON.parse(json)
        puts response

    end
    
end