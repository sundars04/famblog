class Article < ApplicationRecord
  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories
  has_many :likes

  scope :sorted, -> {order("created_at DESC")}

  validates :title, presence: true, length: {minimum: 5, maximum: 100}
  validates :description, presence:true, length: {minimum: 10}
  validates :user_id, presence: true

  has_attached_file :image, styles: { medium: "640x350>", thumb: "100x100#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  acts_as_commentable

end