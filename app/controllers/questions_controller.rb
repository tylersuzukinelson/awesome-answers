class QuestionsController < ApplicationController

  before_action :find_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all.order("created_at DESC")
  end

  # used to show the form to create the resource
  def new
    @question = Question.new
  end

  # used to create the resource
  # expect to receive params submitted from the form shown in the new page
  def create
    # To mass assign in the Question.create method, the params must be first .permit(ted)
    @question = Question.new question_params
    if @question.save
      redirect_to @question, notice: "Question created successfully!"
    else
      render :new
    end
  end

  def show
    @question.increment!(:view_count)
    @answer = Answer.new
    @answers = @question.answers
  end

  def edit
  end

  def update
    if @question.update question_params
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    if @question.destroy
      redirect_to :questions
    else
      render :edit
    end
  end

  private

  def find_question
    @question = Question.find params[:id]
  end

  def question_params
    params.require(:question).permit([:title, :body])
  end

end
