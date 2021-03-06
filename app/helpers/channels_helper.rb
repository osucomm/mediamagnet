module ChannelsHelper
  def channel_action_links(channel, actions=[:update, :destroy, :refresh])
    links = []
    type = channel.class.model_name.singular

    if actions.include?(:update) && policy(channel).update?
      links << (link_to fa_icon('pencil', data: {toggle: 'tooltip', placement: 'top'}, title: 'Edit'),
        edit_channel_path(channel), class: 'btn btn-primary btn-xs action-button')
    end

    if actions.include?(:refresh) && policy(channel).refresh?
      links << (link_to fa_icon('refresh', data: {toggle: 'tooltip', placement: 'top'}, title: 'Refresh'),
                "/channels/#{channel.id}/refresh", class: 'btn btn-primary btn-xs action-button')
    end

    if actions.include?(:destroy) && policy(channel).destroy?
      links << (link_to_delete fa_icon('trash', data: {toggle: 'tooltip', placement: 'top'}, title: 'Delete'),
        channel, 'btn btn-danger btn-xs action-button')
    end

    links.join(' ').html_safe
  end

  def link_to_channel(channel, options={})
    link_to (fa_icon channel.icon, text: channel.name, right: true), channel_path(channel), options
  end

  def link_to_channel_with_warning(channel, options={})
    icon = channel.approved? ? '' : ' '+fa_icon('exclamation-triangle')
    "#{link_to_channel(channel, options)}#{icon}".html_safe
  end

  def with_icon(channel)
    fa_icon channel.icon, text: channel.name, right: true
  end

  def with_unicode_icon(channel)
    "&#x#{channel.unicode_icon}; #{channel.name}".html_safe
  end

  def channel_icon(channel)
    image_tag("#{channel.type_name.downcase}-box.svg", class: 'channel-type-icon')
  end

  def service_url_for(channel)
    channel.respond_to?(:service_url) ? channel.service_url : url_for(channel)
  end

end
