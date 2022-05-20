class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.text :title
      t.string :image
      t.string :author
      t.string :publisher
      t.string :year
      t.string :isbn

      t.timestamps
    end
  end
end
