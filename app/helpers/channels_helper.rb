module ChannelsHelper
  def channel_action_links(channel, actions=[:update, :destroy])
    links = []
    type = channel.class.model_name.singular

    if actions.include?(:update) && policy(channel).update?
      links << (link_to fa_icon('pencil', data: {toggle: 'tooltip', placement: 'top'}, title: 'Edit'),
        edit_channel_path(channel), class: 'btn btn-primary btn-xs action-button')
    end

    if actions.include?(:destroy) && policy(channel).destroy?
      links << (link_to fa_icon('trash', data: {toggle: 'tooltip', placement: 'top'}, title: 'Delete'),
        channel, class: 'btn btn-danger btn-xs action-button', method: :delete)
    end

    links.join(' ').html_safe
  end

  def link_to_channel(channel, options={})
    link_to (fa_icon channel.icon, text: channel.name, right: true), channel_path(channel), options
  end

end
