class Category < ActiveRecord::Base
  has_many :posts, dependent: :nullify

  validates :name, presence: true, uniqueness: true
end
