module EntitiesHelper

  def entity_action_links(entity)
    links = []
    if current_user.entities.exclude?(entity)
      links << (link_to 'Join', entity_path(entity))
    end
    if entity.has_user? current_user
      links << (link_to 'Edit', edit_entity_path(entity))
    end
    if current_user.admin?
      links << (link_to 'Destroy', entity_path(entity), method: :delete, 
                data: { confirm: 'Are you sure?' })
    end
    links.join(' | ').html_safe
  end
end
