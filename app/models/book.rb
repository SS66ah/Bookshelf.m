# == Schema Information
#
# Table name: books
#
#  id             :integer          not null, primary key
#  author         :string
#  content        :text
#  image          :text
#  isbn           :string
#  publisher      :string
#  title          :text
#  year           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  rental_user_id :integer
#  user_id        :integer
#
# Indexes
#
#  index_books_on_rental_user_id  (rental_user_id)
#
# Foreign Keys
#
#  rental_user_id  (rental_user_id => users.id)
#
class Book < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy

    has_many :rentals
    has_many :rental_users, through: :rentals, source: :user , dependent: :destroy

    #rentalsの中のreturned: falseのものを絞り込み
    scope :now_rentals, -> {eager_load(:rentals).where(rentals: {returned: false})}

    def rental_user
        #本に紐づいている、一番最新で借りている人
        not_returned_rental = rentals.where(returned: false).first
        #一番最新で借りている人がnilの場合にエラーが出ないようにする
        #&.：レシーバがnilでもエラーを返さない
        not_returned_rental&.user
    end

    #.present?：レシーバーの値が存在すればtrue、存在しなければfalseを返すメソッド
    #now_rentalがfalse(貸出中)のデータが存在する時→trueを返す
    def now_rental?
        rentals.now_rental.present?
    end 

    #imageアップローダーと紐付け
    mount_uploader :image, ImageUploader


    validates :title, presence: true, length: { maximum: 200 }
    validates :author,length: { maximum: 200 }
    validates :isbn,length: { maximum: 50 }
    validates :publisher,length: { maximum: 100 }
    validates :year,length: { maximum: 50 }
    validates :content,length: { maximum: 2000 }

end
