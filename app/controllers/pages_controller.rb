class PagesController < ApplicationController
  def home
    @jobs = Job.take(5)
  end
end
