class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @question = Question.last
    @answers = @question.answers
    if @answers.any?
      selected_answers = @answers.map { |o| o.selected_answer }
      @answers_data = {
        @question.answer_1 => selected_answers.count { |o| o == "answer_1" },
        @question.answer_2 => selected_answers.count { |o| o == "answer_2" },
        @question.answer_3 => selected_answers.count { |o| o == "answer_3" }
      }
    else
      @answers_data = []
    end
  end

  def new
    @question = Question.last
    @answer = Answer.new
  end

  def create
    @question = Question.last
    @answer = current_user.answers.build(question_id: @question.id)
    answer_data = { @question.answer_1 => 1, @question.answer_2 => 2, @question.answer_3 => 3 }
    @answer.selected_answer = answer_data[params['commit']]
    # 質問が変更されたときに@answerをリセット
    if @question.changed?
      @answer = nil
    end
    @answer.save!
    flash[:notice] = "解答しました."
    redirect_to answers_path
  end
end
