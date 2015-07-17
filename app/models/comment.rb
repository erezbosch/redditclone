class Comment < ActiveRecord::Base

  validates :author, :post, presence: true

  belongs_to :author, foreign_key: :user_id, primary_key: :id, class_name: User
  belongs_to :post
  has_many :child_comments, foreign_key: :parent_comment_id, primary_key: :id, class_name: Comment
  

end
