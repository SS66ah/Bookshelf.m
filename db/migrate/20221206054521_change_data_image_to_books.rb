class ChangeDataImageToBooks < ActiveRecord::Migration[6.1]
  def change
  end
  def change
    change_column :books, :image, :text
  end
end
