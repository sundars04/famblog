class Like < ApplicationRecord
  belongs_to :user, inverse_of: :likes
  belongs_to :article, inverse_of: :likes
end
