class UpdateItemEsRecordJob < ActiveJob::Base
  queue_as :default

  def perform(item)
    item.update_es_record
  end
end
