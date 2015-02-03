class AnswersController < ApplicationController

  before_action :authenticate_user!

  def create
    @question = Question.find params[:question_id]
    @answer = @question.answers.new permitted_params
    @answer.user = current_user
    respond_to do |format|
      if @answer.save
        AnswersMailer.notify_question_owner(@answer).deliver_later
        format.html { redirect_to @question }
        format.js { render }
      else
        format.html { render "questions/show", notice: error_messages }
        format.js { render js: "alert('#{error_messages}')"}
      end
    end
  end

  def destroy
    @question = current_user.questions.find params[:question_id]
    @answer = current_user.answers.find params[:id]
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
