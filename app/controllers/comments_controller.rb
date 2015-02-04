class CommentsController < ApplicationController

  def create
    @answer = Answer.find params[:answer_id]
    @comment = Comment.new comment_params
    @comment.answer = @answer
    respond_to do |format|
      if @comment.save
        format.html { redirect_to question_path(@answer.question) }
        format.js { render }
      else
        format.html { redirect_to question_path(@answer.question), notice: @comment.errors.full_messages.join('; ') }
        format.js { render }
      end
    end
  end

  def destroy
    @comment = Comment.find params[:id]
    respond_to do |format|
      if @comment.destroy
        format.html { redirect_to @comment.answer.question }
        format.js { render }
      else
        format.html { redirect_to @comment.answer.question, notice: @comment.errors.full_messages.join('; ') }
        format.js { render }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
