class AddReferencesToBooks < ActiveRecord::Migration[6.1]
  def change
    add_reference :books,:rental_user, foreign_key: { to_table: :users }, comment:"本を借りているユーザー" 
  end
end
