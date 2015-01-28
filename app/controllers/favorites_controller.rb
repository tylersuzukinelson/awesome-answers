class FavoritesController < ApplicationController

  before_action :authenticate_user!

  def create
    @question = Question.find params[:question_id]
    @favorite = @question.favorites.new user_id: current_user.id
    if @favorite.save
      redirect_to @question
    else
      redirect_to @question, notice: error_messages
    end
  end

  def destroy
    @question = Question.find params[:question_id]
    @favorite = Favorite.find params[:id]
    if @favorite.destroy
      redirect_to @question
    else
      redirect_to @question
    end
  end

  private

  def error_messages
    @favorite.errors.full_messages.join('; ')
  end

end
