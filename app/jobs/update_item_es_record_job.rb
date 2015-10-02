class UpdateItemEsRecordJob < ActiveJob::Base
  queue_as :default

  rescue_from ActiveJob::DeserializationError do |exception|
    logger.debug "Tried to update a record that was deleted"
  end

  def perform(item)
    item.update_es_record
  end
end
