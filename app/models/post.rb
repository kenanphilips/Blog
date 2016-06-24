class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  has_many :favourites, dependent: :destroy
  has_many :users, through: :favourites

  has_many :comments, dependent: :destroy

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, presence: true, uniqueness: true
  validates :body, presence: true

  def self.search(search)
    where("title ILIKE ? OR body ILIKE ?", "%#{search}%", "%#{search}%")
  end

  def new_first_comments
    comments.order(created_at: :desc)
  end

  def favourited_by?(user)
  favourites.exists?(user: user)
  end

def favourite_for(user)
  favourites.find_by_user_id user
  end
end
