class Vote < ActiveRecord::Base
  validates :value, :votable, presence: true
  validates :value, inclusion: { in: [-1, 1] }
  belongs_to :votable, polymorphic: true
end
