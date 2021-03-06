class ProfilesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :bookmark]
  before_action :authenticate_headhunter!, only: [:show, :bookmark]
  #before_action :check_profile_presence, only: [:new, :create]

  
  def new
    if Profile.where("user_id = ?", current_user.id).blank? 
      @profile = current_user.profiles.build
    else
      redirect_to edit_profile_path(current_user.id)
    end
  end

  def create
    @user = current_user
    @profile = @user.profiles.create(profile_params)
    if @profile.save
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
    @profile = current_user.profiles.find_by(user_id: current_user.id)
  end

  def show
    @profile = Profile.find_by(user_id: params[:id])
    @comments = @profile.comments.all
    @comment = @profile.comments.build
  end

  def bookmark
    if Favorite.exists?(profile_id: params[:profile_id], headhunter_id: params[:headhunter_id])
      flash[:alert] = "Esse perfil já está nos seus favoritos."
    else
      @favorite = Favorite.new(profile_id: params[:profile_id], headhunter_id: params[:headhunter_id])
      @favorite.save
      flash[:notice] = "Perfil incluído nos seus favoritos."
    end
    redirect_to request.referrer
  end

  private
    def profile_params
      params.require(:profile).permit(:name, :social_name, :birth_date, :formation, :description, :experience, :picture, :user_id)
    end
  
end