class RefreshChannelJob < Struct.new(:channel)
  def perform
    # Only actually run if our job has this channel locked. Otherwise silently
    # skip.
    if @job.id == channel.refresh_lock.job_id
      channel.refresh_items
    end
    true
  end

  def before(job)
    @job = job
    channel.lock(job_id: job.id)
  end

  def success(job)
    # Remove lock if this is really our job.
    channel.unlock if channel.refresh_lock && channel.refresh_lock.job_id == job.id
  end
end
