module KeywordsHelper
  def keyword_action_links(keyword, actions=[:update, :destroy])
    links = []

    if actions.include?(:update) && policy(keyword).update?
      links << (link_to fa_icon('pencil', data: {toggle: 'tooltip', placement: 'top'}, title: 'Edit'),
        edit_keyword_path(keyword), class: 'btn btn-primary btn-xs action-button')
    end

    if actions.include?(:destroy) && policy(keyword).destroy?
      links << (link_to_delete fa_icon('trash', data: {toggle: 'tooltip', placement: 'top'}, title: 'Delete'),
        keyword, 'btn btn-danger btn-xs action-button')
    end

    links.join(' ').html_safe
  end

  def keyword_labels(keywords)
    Array(keywords).map do |keyword|
      #link = link_to keyword.name, keyword
      link = keyword.name
      bootstrap_label_with_tooltip(link, type: :primary, title: keyword.description)
    end.join(' ').html_safe
  end

end
