class RefreshLock < ActiveRecord::Base
  belongs_to :channel

  validates :channel_id, uniqueness: true

  def job
    Delayed::Job.find(job_id)
  end

end
