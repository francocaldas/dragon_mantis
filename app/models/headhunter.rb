class Headhunter < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :jobs
  accepts_nested_attributes_for :jobs

  has_many :comments
  has_many :profiles, :through => :comments

  has_many :favorites
  has_many :profiles, :through => :favorites
end
