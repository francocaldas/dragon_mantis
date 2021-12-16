class FavoritesController < ApplicationController
  before_action :authenticate_headhunter!, only: [:index]
  
  def index
    @favorites = current_headhunter.favorites
  end
  
end