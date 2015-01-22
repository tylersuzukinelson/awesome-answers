class CommentsController < ApplicationController

  def create
    @answer = Answer.find params[:answer_id]
    @comment = Comment.new comment_params
    @comment.answer = @answer
    if @comment.save
      redirect_to question_path(@answer.question)
    else
      redirect_to question_path(@answer.question), notice: @comment.errors.full_messages.join('; ')
    end
  end

  def destroy
    @comment = Comment.find params[:id]
    if @comment.destroy
      redirect_to @comment.answer.question
    else
      redirect_to @comment.answer.question, notice: @comment.errors.full_messages.join('; ')
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
