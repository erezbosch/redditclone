class Post < ActiveRecord::Base
  validates :title, :subs, :author, presence: true
  belongs_to(
    :author,
    foreign_key: :author_id,
    primary_key: :id,
    class_name: :User
  )

  has_many :post_subs
  has_many :subs, through: :post_subs, source: :sub
end
