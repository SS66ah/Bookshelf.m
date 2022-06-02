# == Schema Information
#
# Table name: rentals
#
#  id         :integer          not null, primary key
#  returned   :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_rentals_on_book_id  (book_id)
#  index_rentals_on_user_id  (user_id)
#
# Foreign Keys
#
#  book_id  (book_id => books.id)
#  user_id  (user_id => users.id)
#
class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :book
end
