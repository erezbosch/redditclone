class Comment < ActiveRecord::Base

  validates :author, :post, presence: true

  belongs_to :author, foreign_key: :user_id, primary_key: :id, class_name: User
  belongs_to :post
  has_many(
    :child_comments,
    foreign_key: :parent_comment_id,
    primary_key: :id,
    class_name: Comment
    )

  belongs_to(
    :parent_comment,
    foreign_key: :parent_comment_id,
    primary_key: :id,
    class_name: Comment
  )

  has_many :votes, as: :votable

  def score
    votes.pluck(:value).sum
  end
end
