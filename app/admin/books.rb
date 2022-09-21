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
  
end
