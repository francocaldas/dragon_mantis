class Subscription < ApplicationRecord
  belongs_to :job
  belongs_to :user

  def profile_name
    @profile = Profile.find_by(user_id: user_id)
    "#{@profile.name}"
  end

  def profile_id
    @profile = Profile.find_by(user_id: user_id)
    return @profile.id
  end
  
end
