class Post < ApplicationRecord
  include Visible
  
  belongs_to :author, class_name: 'User'

  has_many :comments, dependent: :destroy
  validates :title, presence: true

  scope :published, ->(value = "public", user){where("status=? OR author_id=?", value, user)}
  
  scope :mine, ->(value){where("author": value)}
  scope :ordered, ->(direction= :desc){ order(created_at: direction)}
  scope :with_authors, -> { includes(:author)}
  scope :search, ->(query) do 
    return if query.blank?  
    where('title LIKE ? OR title LIKE ?', "#{query.squish}%", "% #{query.squish}%")
  end
end