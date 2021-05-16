class Comment < ApplicationRecord
  include Visible
  belongs_to :post
  belongs_to :author, class_name: "User"
end
