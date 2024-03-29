ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  permit_params :email, :name,:encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at,:password, :password_confirmation

  form do |f|
    f.inputs do
      
      f.input :name , label: '名前'
      f.input :email ,label: 'メールアドレス'
      f.input :password ,label: 'パスワード'
      f.input :password_confirmation ,label: '確認用パスワード'
    end
    f.actions
  end
  
end
