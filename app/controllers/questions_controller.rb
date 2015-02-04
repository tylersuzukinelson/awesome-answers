class QuestionsController < ApplicationController

  before_action :find_question, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!, except: [:index, :show]

  before_action :restrict_access, only: [:edit, :update, :destroy]

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
    @question.user = current_user
    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: "Question created successfully!" }
        format.js { render }
      else
        format.html { render :new }
        format.js { render js: "alert('failure');" }
      end
    end
  end

  def show
    @question.increment!(:view_count)
    @answer = Answer.new
    respond_to do |format|
      format.html { render }
      format.json { render json: @question.to_json }
      format.text { render text: @question.title }
      format.xml { render xml: @question.to_xml }
    end
  end

  def edit
    redirect_to root_path, alert: "Not enough minerals." unless can? :edit, @question
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
    @question = Question.friendly.find params[:id]
  end

  def question_params
    params.require(:question).permit([:title, :body, {category_ids: []}])
  end

  def restrict_access
    redirect_to root_path, alert: "Not enough minerals." unless can? :manage, @question
  end

end
