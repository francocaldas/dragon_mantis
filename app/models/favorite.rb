class Favorite < ApplicationRecord
  belongs_to :headhunter
  belongs_to :profile

  def profile_name
    @profile = Profile.find_by(id: profile_id)
    "#{@profile.name}"
  end
  
end
