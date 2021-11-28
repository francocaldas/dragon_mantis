class Job < ApplicationRecord
  belongs_to :headhunter
  accepts_nested_attributes_for :headhunter
end
