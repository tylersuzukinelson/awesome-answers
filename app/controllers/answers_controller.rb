class AnswersController < ApplicationController

  before_action :user_authentication!

  def create
    @question = Question.find params[:question_id]
    @answer = @question.answers.new permitted_params
    @answer.user = current_user
    if @answer.save
      redirect_to @question
    else
      render "questions/show", notice: error_messages
    end
  end

  def destroy
    @question = Question.find params[:question_id]
    @answer = Answer.find params[:id]
    if @answer.destroy
      redirect_to @question
    else
      render "questions/show", notice: error_messages
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
