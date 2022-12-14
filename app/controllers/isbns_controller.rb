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

        #登録済みのISBNコードが入力された時
        if
            Book.where(isbn: "#{params[:isbn]}").count >= 1
            flash[:info] = "登録済みのISBNコードが入力されたため登録できませんでした"
            redirect_to new_book_isbns_path
            return
        end

        #ISBNコードがないor適当な数字の時
        if response == [nil]
            flash[:info] ="ISBNコードが存在しません"
            redirect_to new_book_isbns_path
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

            if response[0]["onix"]["CollateralDetail"].present?
                if response[0]["onix"]["CollateralDetail"]["TextContent"].present?
                    if response[0]["onix"]["CollateralDetail"]["TextContent"][0].present?
                        if response[0]["onix"]["CollateralDetail"]["TextContent"][0]["TextType"] == "04"
                            content = response[0]["onix"]["CollateralDetail"]["TextContent"][0]["Text"]
                        end
                    end

                    if response[0]["onix"]["CollateralDetail"]["TextContent"][1].present?
                        if response[0]["onix"]["CollateralDetail"]["TextContent"][1]["TextType"] == "04"
                            content = response[0]["onix"]["CollateralDetail"]["TextContent"][1]["Text"]
                        end
                    end

                    if response[0]["onix"]["CollateralDetail"]["TextContent"][2].present?
                        if response[0]["onix"]["CollateralDetail"]["TextContent"][2]["TextType"] == "04"
                            content = response[0]["onix"]["CollateralDetail"]["TextContent"][2]["Text"]
                        end
                    end

                    if response[0]["onix"]["CollateralDetail"]["TextContent"][3].present?
                        if response[0]["onix"]["CollateralDetail"]["TextContent"][3]["TextType"] == "04"
                            content = response[0]["onix"]["CollateralDetail"]["TextContent"][3]["Text"]
                        end
                    end
                end
            end


        
            @book = Book.new(
                            title: title,
                            author: author,
                            publisher: publisher,
                            year: pubdate,
                            isbn: isbn,
                            content: content
                            )
            @book.user = current_user
            @book.remote_image_url = image


            if @book.save
                flash[:success] ="書籍情報が正しく登録されました"
                redirect_to new_book_isbns_path
                
            else
                flash[:danger] ="正常に登録されませんでした"
                redirect_to new_book_isbns_path
            end
        end
    end
end