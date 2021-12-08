class Job < ApplicationRecord
  belongs_to :headhunter
  accepts_nested_attributes_for :headhunter
  has_many :subscriptions
  has_many :users, through: :subscriptions
end
