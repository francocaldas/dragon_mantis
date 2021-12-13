class Subscription < ApplicationRecord
  belongs_to :job
  belongs_to :user

  def profile_name
    @profile = Profile.find_by(user_id: user_id)
    "#{@profile.name}"
  end
end
