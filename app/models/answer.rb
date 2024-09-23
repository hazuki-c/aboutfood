class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  
  enum selected_answer: { answer_1: 1, answer_2: 2, answer_3: 3 }
  validates :selected_answer, presence: true
end
