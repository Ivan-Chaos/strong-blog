class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #:rememberable,
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable

  has_many :posts, foreign_key: :author_id ,inverse_of: :author
  has_many :comments, inverse_of: :author

  ROLES = {
    user: 0,
    dungeonMaster: 1,
  }.with_indifferent_access.freeze

  enum role: ROLES
end
