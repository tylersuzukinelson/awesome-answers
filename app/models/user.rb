class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :questions, dependent: :nullify
  has_many :answers, dependent: :nullify

  has_many :likes, dependent: :destroy
  has_many :liked_questions, through: :likes, source: :question

  has_many :favorites, dependent: :destroy
  has_many :favorited_questions, through: :favorites, source: :question

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def has_liked?(question)
    liked_questions.include? question
  end
end
