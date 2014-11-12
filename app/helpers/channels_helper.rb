module ChannelsHelper
  def channel_action_links channel
    links = []
    type = channel.class.model_name.singular
    if channel.entity.has_user? current_user
      links << (link_to 'Edit', edit_channel_path(channel))
    end
    if current_user.admin?
      links << (link_to 'Delete', channel, method: :delete)
    end
    links.join(' | ').html_safe
  end
end
