module ChannelsHelper
  def channel_action_links channel
    links = []
    type = channel.class.model_name.singular
    if policy(channel).update?
      links << (link_to 'Edit', edit_channel_path(channel))
    end
    if policy(channel).destroy?
      links << (link_to 'Delete', channel, method: :delete)
    end
    links.join(' | ').html_safe
  end
end
