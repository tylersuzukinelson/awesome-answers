class AnswersController < ApplicationController

  def create
    @question = Question.find params[:question_id]
    @answer = @question.answers.new permitted_params
    if @answer.save
      redirect_to @question
    else
      redirect_to @question, notice: error_messages
    end
  end

  private

  def permitted_params
    @output = params.require(:answer).permit(:body)
  end

  def error_messages
    @answer.errors.full_messages.join('; ')
  end

end
