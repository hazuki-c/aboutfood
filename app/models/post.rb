class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user,optional: true
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
  
  # 検索方法分岐
  def self.search(word)
    Post.where("title LIKE ?", "%#{word}%")
  end
  
  
end
