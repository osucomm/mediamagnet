# Patch ActiveJob Sidekiq adapter to Rails 5 behavior
# THIS IS BAD. REMOVE WHEN UPDATING TO RAILS 5!

ActiveJob::QueueAdapters::SidekiqAdapter.class_eval do
  class << self

    def enqueue(job) #:nodoc:
      #Sidekiq::Client does not support symbols as keys
      job.provider_job_id = Sidekiq::Client.push \
        'class'   => ActiveJob::QueueAdapters::SidekiqAdapter::JobWrapper,
        'wrapped' => job.class.to_s,
        'queue'   => job.queue_name,
        'args'    => [ job.serialize ]
    end

    def enqueue_at(job, timestamp) #:nodoc:
      job.provider_job_id = Sidekiq::Client.push \
        'class'   => ActiveJob::QueueAdapters::SidekiqAdapter::JobWrapper,
        'wrapped' => job.class.to_s,
        'queue'   => job.queue_name,
        'args'    => [ job.serialize ],
        'at'      => timestamp
    end

  end
end
