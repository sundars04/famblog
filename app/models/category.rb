class Category < ApplicationRecord

  has_many :article_categories
  has_many :articles, through: :article_categories
  validates :name, presence: true, length: {minimum: 3, maximum: 30}
  validates_uniqueness_of :name

  scope :sorted, -> {order("created_at DESC")}

end