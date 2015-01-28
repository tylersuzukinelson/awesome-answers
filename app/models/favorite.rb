class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  validates :question, uniqueness: {scope: :user}

end
