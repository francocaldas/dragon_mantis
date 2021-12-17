class Comment < ApplicationRecord
  belongs_to :profile
  belongs_to :headhunter

  def headhunter_email
    @headhunter = Headhunter.find_by(id: headhunter_id)
    "#{@headhunter.email}"
  end
  
end
