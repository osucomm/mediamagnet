module KeywordingHelper

  def manage_keywording(keywording, on_parent = false)
    link = link_to keywording.keyword.name, keywording.keyword

    if ! on_parent && policy(keywording).destroy?
      link += link_to_delete (fa_icon 'remove'), keywording, :delete
    end
    bootstrap_label_with_tooltip(content_tag(:span, link, class: 'nowrap'), type: :primary, title: keywording.keyword.description, id: "keywording-#{keywording.id}")
  end

end
