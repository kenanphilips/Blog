class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  
  validates :title, presence: true, uniqueness: true
  validates :body, presence: true

  def self.search(search)
    where("title ILIKE ? OR body ILIKE ?", "%#{search}%", "%#{search}%")
  end

  def new_first_comments
  comments.order(created_at: :desc)
end
end
