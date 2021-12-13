class JobsController < ApplicationController
  before_action :authenticate_headhunter!, except: [:index, :show, :enroll]
  before_action :authenticate_user!, only: [:show, :enroll]

  def new
    @job = Job.new
  end

  def create
    @headhunter = current_headhunter
    @job = @headhunter.jobs.create(job_params)
    if  @job.save
      :new
      redirect_to jobs_path
    end
  end

  def index
    @jobs = current_headhunter.jobs
  end

  def show
    @jobs = Job.find(params[:id])
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])

    if @job.update(job_params)
      redirect_to root_path
      flash[:notice] = "Vaga atualizada com sucesso."
    else
      render action: "edit"
    end
  end
  
  def enroll
    @subscription = Subscription.new(job_id: params[:job_id], user_id: params[:user_id])
    @subscription.save
    flash[:notice] = "Inscrição realizada com sucesso."
    redirect_to root_path
  end

  private
    def job_params
      params.require(:job).permit(:title, :description, :skills, :salary_range, :level, :deadline, :location, :closed)
    end
end