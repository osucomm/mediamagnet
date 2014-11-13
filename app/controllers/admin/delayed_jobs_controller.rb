class Admin::DelayedJobsController < ApplicationController
  def index
    authorize :delayed_job, :index?
    @delayed_jobs = Delayed::Job.all
  end
  def destroy
    authorize :delayed_job, :destroy?
    @job = Delayed::Job.where(id: params[:id]).first
    @job.destroy
    redirect_to admin_delayed_jobs_url
  end
end
