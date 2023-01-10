ActiveAdmin.register Book do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :image, :author, :publisher, :year, :isbn, :user_id, :rental_user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :image, :author, :publisher, :year, :isbn, :user_id, :rental_user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  permit_params :title, :author, :publisher, :year, :isbn, :image,:user_id, :rental_user_id
  index do
    selectable_column
    id_column
    column :title
    column :isbn
    column :year
    column :author
    column :publisher
    actions
  end
  show do
    attributes_table do
      row 'タイトル' do
        resource.title
      end
      row 'ISBN' do
        resource.isbn
      end
      row '出版日' do
        resource.year
      end
      row '著者' do
        resource.author
      end
      row '出版社' do
        resource.publisher
      end
      row '目次' do
        resource.content
      end
    end
  end
end
