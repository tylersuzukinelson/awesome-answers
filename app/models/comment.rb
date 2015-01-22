class Comment < ActiveRecord::Base
  belongs_to :answer

  # delegate :question, to: :answer
  def question
    answer.question
  end

end
