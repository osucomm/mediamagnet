module KeywordsHelper
  def keyword_action_links keyword
    links = []
    if current_user.is_admin?
      links << (link_to 'Edit', edit_keyword_path(keyword))
      links << (link_to 'Delete', keyword_path(keyword), method: :delete)
    end
    links.join(' | ').html_safe
  end
end
