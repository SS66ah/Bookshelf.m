require 'csv'
require 'open-uri'

# rake import:bole_db
namespace :import do
  #このdescはdescribeのdesc
  desc "Import books from csv"

  task books: :environment do
    path = File.join Rails.root, "db/csv/bole_db.csv"
    puts "path: #{path}"
    list = []
    CSV.foreach(path, headers: true) do |row|
      list << {
          isbn: row["isbn"],
          title: row["title"],
          author: row["author"],
          publisher: row["publisher"],
          year: row["year"],
          user_id: row["user_id"],
          image: row["cover"]
      }
    end
    puts "start to create books data"
    binding.pry
    begin
      Book.create!(list) #クラス名注意
      puts "completed!!"
    rescue ActiveModel::UnknownAttributeError => invalid
      puts "raised error : unKnown attribute "
    end
  end
end

