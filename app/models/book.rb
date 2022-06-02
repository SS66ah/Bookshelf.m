# == Schema Information
#
# Table name: books
#
#  id             :integer          not null, primary key
#  author         :string
#  image          :string
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
end
