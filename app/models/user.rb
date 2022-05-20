class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         #ユーザーがデータベースから削除されてしまった場合にユーザーがした登録情報も全て消える
         has_many :books, dependent: :destroy
         #ユーザーがデータベースから削除されてしまった場合にユーザーがしたコメントも全て消える
         has_many :comments, dependent: :destroy
end
