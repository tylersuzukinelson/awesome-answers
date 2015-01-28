class LikesController < ApplicationController

  before_action :authenticate_user!

  def create
    @question = Question.find params[:question_id]
    @like = @question.likes.new
    @like.user = current_user
    if @like.save
      redirect_to @question
    else
      redirect_to @question, notice: error_messages
    end
  end

  def destroy
    @like = Like.find params[:id]
    @question = Question.find params[:question_id]
    if @like.destroy
      redirect_to @question
    else
      redirect_to @question, notice: error_messages
    end
  end

  private

  def error_messages
    @like.errors.full_messages.join('; ')
  end

end
