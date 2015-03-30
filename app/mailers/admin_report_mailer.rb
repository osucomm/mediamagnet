class AdminReportMailer < ApplicationMailer
  def admin_report
    @unused_entities = Entity.without_channels
    active_items = Item.between(2.days.ago.at_midnight, 1.day.ago.at_midnight)
    @active_items_count = active_items.count
    @active_channels_count = active_items.map(&:channel).uniq.count
    @stale_channels = Channel.stale_for_days(7)
    mail(to: User.admin.pluck(:email), subject: '[Media Magnet] Daily Report')
  end

  def stale_channels(channel)
    @channel = channel
    mail(to: channel.entity.users.pluck(:email), subject: '[Media Magnet] Stale Channel Notification')
  end

end
