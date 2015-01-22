class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
has_many :questions, dependent: :nullify
has_many :answers, dependent: :nullify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
