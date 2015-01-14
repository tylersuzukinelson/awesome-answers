class QuestionsController < ApplicationController

  # used to show the form to create the resource
  def new
    @question = Question.new
  end

  # used to create the resource
  # expect to receive params submitted from the form shown in the new page
  def create
    # To mass assign in the Question.create method, the params must be first .permit(ted)
    question_params = params.require(:question).permit([:title, :body])
    @question = Question.new question_params
    if @question.save
      render text: "Thank You!"
    else
      render :new
    end
  end

end
