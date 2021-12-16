class Profile < ApplicationRecord
  belongs_to :user

  has_many :comments
  has_many :headhunters, :through => :comments

  has_many :favorites
  has_many :headhunters, :through => :favorites

  def self.incomplete
    !where(name: [nil, '']).or(where(social_name: [nil, ''])).or(where(birth_date: [nil])).or(where(formation: [nil, ''])).or(where(description: [nil, ''])).or(where(experience: [nil, ''])).blank?
  end
end
