class ProfilesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def new
    @profile = Profile.new
  end

  def create
    @user = current_user
    @profile = @user.profiles.create(profile_params)
    if  @profile.save
      :new
      redirect_to root_path
    end
  end

  private
    def profile_params
      params.require(:profile).permit(:name, :social_name, :birth_date, :formation, :description, :experience, :picture)
    end
  
end