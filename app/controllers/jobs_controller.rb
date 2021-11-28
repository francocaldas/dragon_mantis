class JobsController < ApplicationController
  before_action :authenticate_headhunter!, except: [:index]

  def new
    @job = Job.new
  end

  def create
    @headhunter = current_headhunter
    @job = @headhunter.jobs.create(job_params)
    if  @job.save
      :new
      redirect_to root_path
    end
  end

  private
    def job_params
      params.require(:job).permit(:title, :description, :kills, :salary_range, :level, :deadline, :location)
    end
end