class Post < ApplicationRecord
  include Visible
  
  belongs_to :author, class_name: 'User'

  has_many :comments, dependent: :destroy
  has_one_attached :file

  validates :title, presence: true
  validates :file, content_type: ['image/png', 'image/jpg', 'image/jpeg'], dimension: { width: { in: 100..5000 }, message: 'has width less than 100px or more than 5000' }, dimension: { height: { in: 100..5000 }, message: 'has height less than 100px or more than 5000' }


  scope :published, ->(value = "public", user){where("status=?", value)}
  scope :non_published, ->(){where("status=?", "private")}
  
  scope :mine, ->(value){where("author": value)}
  scope :ordered, ->(direction= :desc){ order(created_at: direction)}
  scope :with_authors, -> { includes(:author)}
  scope :search, ->(query) do 
    return if query.blank?  
    where('title LIKE ? OR title LIKE ?', "#{query.squish}%", "% #{query.squish}%")
  end
end