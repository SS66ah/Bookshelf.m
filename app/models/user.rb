# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         #ユーザーがデータベースから削除されてしまった場合にユーザーがした登録情報も全て消える
         has_many :books, dependent: :destroy
         #ユーザーがデータベースから削除されてしまった場合にユーザーがしたコメントも全て消える
         has_many :comments, dependent: :destroy

        has_many :rentals
        has_many : rental_books, through :  :rentals, source: :book
        
        scope :now_rental_users, -> {eager_load(:rentals).where(rentals: {returned: false})}
end
