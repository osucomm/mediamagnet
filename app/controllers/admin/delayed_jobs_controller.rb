class Admin::DelayedJobsController < Admin::BaseController
  def index
    authorize :delayed_job, :index?
    @delayed_jobs = Delayed::Job.all.page(params[:page]).per(params[:per])
  end
  def flush_refresh_queue
    authorize :delayed_job, :destroy?
    Delayed::Job.where(queue: 'refresh').destroy_all
    redirect_to admin_delayed_jobs_url
  end
  def destroy
    authorize :delayed_job, :destroy?
    @job = Delayed::Job.where(id: params[:id]).first
    @job.destroy
    redirect_to admin_delayed_jobs_url
  end
end
