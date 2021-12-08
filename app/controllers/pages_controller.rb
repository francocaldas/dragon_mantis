# frozen_string_literal: true

# Controller da homepage
class PagesController < ApplicationController
  #skip_before_action :authenticate_user!, only: [:home]
  #skip_before_action :authenticate_headhunter!, only: [:home]

  def home
    if headhunter_signed_in? 
       redirect_to jobs_path
    else
      @jobs = Job.take(5)
    end
  end
end
