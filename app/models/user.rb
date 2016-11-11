class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  before_save { self.email = email.downcase }

  scope :sorted, -> {order("created_at DESC")}
  
  validates :username, presence: true, 
              uniqueness: {case_sensitive: false},
              length: {minimum: 3, maximum: 40}
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:true, 
              length: {minimum:5, maximum: 105},
              uniqueness: {case_sensitive: false},
              format: {with: EMAIL_REGEX}
  has_secure_password              
end