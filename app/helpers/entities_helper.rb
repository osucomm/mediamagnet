module EntitiesHelper

  def entity_action_links(entity)
    links = []
    if current_user.entities.exclude?(entity)
      links << (link_to fa_icon('users', data: {toggle: 'tooltip', placement: 'top'}, title: 'Join'),
        entity_path(entity), class: 'btn btn-success btn-xs action-button')
    end
    if policy(entity).update?
      links << (link_to fa_icon('pencil', data: {toggle: 'tooltip', placement: 'top'}, title: 'Edit'),
        edit_entity_path(entity), class: 'btn btn-primary btn-xs action-button')
    end
    if policy(entity).destroy?
      links << (link_to fa_icon('trash', data: {toggle: 'tooltip', placement: 'top'}, title: 'Delete'),
        entity_path(entity), class: 'btn btn-danger btn-xs action-button', method: :delete,
        data: { confirm: 'Are you sure?' })
    end
    links.join(' ').html_safe
  end
end
