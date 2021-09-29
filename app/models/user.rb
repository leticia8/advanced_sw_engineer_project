class User < ApplicationRecord
  has_many :elections
  has_many :user_elections
  has_many :elections_voted, through: :user_elections, source: :election 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, :country, :city, :state, :birth_date, presence: true
end
