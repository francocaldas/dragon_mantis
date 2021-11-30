class ProfilesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  #before_action :check_profile_presence, only: [:new, :create]
  
  def new
    if current_user.profiles.empty?
      @profile = Profile.new
    else
      # raise error which doesn't make sense or redirect like
      redirect_to edit_profile_path(current_user.id)
    end
  end

  def create
    @user = current_user
    @profile = @user.profiles.create(profile_params)
    if  @profile.save
      :new
      redirect_to root_path
    end
  end

  def update
    @profile = current_user.profiles.find(params[:id])

    if @profile.update(profile_params)
      redirect_to root_path
    else
      render action: "edit"
    end
  end

  def edit
    @profile = current_user.profiles.find(params[:id])
  end

  private
    def profile_params
      params.require(:profile).permit(:name, :social_name, :birth_date, :formation, :description, :experience, :picture)
    end
  
end