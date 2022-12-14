class AddContentToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :content, :text
  end
end
