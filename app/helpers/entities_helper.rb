module EntitiesHelper

  def action_links(entity)
    links = []
    if current_user.admin?
      links << (link_to 'Destroy', entity_path(entity), method: :delete)
    end
    if current_user.entities.exclude?(entity)
      links << (link_to 'Join', entity_path(entity), method: :delete)
    end
    links.join(', ').html_safe
  end
end
