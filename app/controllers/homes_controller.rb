class HomesController < ApplicationController
  def top
    @user = current_user
    @answer = Answer.new
    @question = Question.last
  end
  
  def about
    
  end
end
