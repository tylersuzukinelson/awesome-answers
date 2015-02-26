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
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:twitter]

  serialize :omniauth_data

  def email_required?
    provider.nil?
  end

  def password_required?
    provider.nil?
  end

  def has_liked?(question)
    liked_questions.include? question
  end

  def has_favorited?(question)
    favorited_questions.include? question
  end

  def favorite_for(question)
    favorites.where(question_id: question.id).first
  end

  def self.find_or_create_from_twitter(omniauth_data)
    user = User.where(provider: :twitter, uid: omniauth_data['uid']).first
    unless user
      name = omniauth_data['info']['name'].split
      user = User.create(
                          provider: :twitter,
                          uid: omniauth_data['uid'],
                          first_name: name[0],
                          last_name: name[1],
                          twitter_consumer_token: omniauth_data['credentials']['token'],
                          twitter_consumer_secret: omniauth_data['credentials']['secret'],
                          omniauth_raw_data: omniauth_data
                        )
    end
    user
  end

end
