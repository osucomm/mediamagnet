module EntitiesHelper

  def entity_action_links(entity, actions=[:update, :destroy])
    links = []

    if actions.include?(:update) && policy(entity).update?
      links << edit_button(edit_entity_path(entity))
    end

    if actions.include?(:destroy) && policy(entity).destroy?
      links << (link_to_delete fa_icon('trash', data: {toggle: 'tooltip', placement: 'top'}, title: 'Delete'),
        entity, 'btn btn-danger btn-xs action-button')
    end

    links.join(' ').html_safe
  end

  def link_to_entity(entity, options={})
    icon = entity.approved? ? '' : ' '+fa_icon('exclamation-triangle')
    "#{link_to(entity.name, entity_path(entity), options)}#{icon}".html_safe
  end
end
