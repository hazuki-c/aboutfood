class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :name, presence: true, length: { minimum: 2 }
  
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post
  
  has_many :answers, dependent: :destroy
  
  has_one_attached :profile_image
  
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  # 検索方法分岐
  def self.looks(word)
    User.where(username: word)
  end
  
  def favorite(post)
    self.favorites.find_or_create_by(post_id: post.id)
  end
  
  def unfavorite(post)
    self.favorites.find_by(post_id: post.id)&.destroy
  end
  
  def favorite?(post)
    self.favorite_posts.include?(post)
  end
end
