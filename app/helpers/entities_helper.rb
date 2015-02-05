module EntitiesHelper

  def entity_action_links(entity, actions=[:update, :destroy])
    links = []

    if actions.include?(:update) && policy(entity).update?
      links << (link_to fa_icon('pencil', data: {toggle: 'tooltip', placement: 'top'}, title: 'Edit'),
        edit_entity_path(entity), class: 'btn btn-primary btn-xs action-button')
    end

    if actions.include?(:destroy) && policy(entity).destroy?
      links << (link_to_delete fa_icon('trash', data: {toggle: 'tooltip', placement: 'top'}, title: 'Delete'),
        entity, 'btn btn-danger btn-xs action-button')
    end

    links.join(' ').html_safe
  end
end
