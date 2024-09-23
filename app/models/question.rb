class Question < ApplicationRecord
  validates :title, presence: true
  validates :answer_1, presence: true
  validates :answer_2, presence: true
  validates :answer_3, presence: true
  
  has_many :answers, dependent: :destroy
end
