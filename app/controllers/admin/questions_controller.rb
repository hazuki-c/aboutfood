class Admin::QuestionsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  
  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:notice] = "success"
      redirect_to admin_question_path(@question)
    else
      flash.now[:danger] = "failed"
      render :new
    end
  end
  
  def edit
    @question = Question.find(params[:id])
  end
  
  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      flash[:notice] = "success"
      redirect_to admin_question_path(@question)
    else
      flash.now[:danger] = "failed"
      render :edit
    end
  end
  
  def destroy
    @question = Question.find_by_id(params[:id])
    @question.destroy if @question
    flash[:notice] = "success"
    redirect_to admin_questions_path
  end
  
  private
  
  def question_params
    params.require(:question).permit(:title, :answer_1, :answer_2, :answer_3)
  end
end
