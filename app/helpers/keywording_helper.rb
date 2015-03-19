module KeywordingHelper

  def manage_keywording(keywording, on_parent = false)
    link = link_to keywording.keyword.name, keywording.keyword
    link += ' '
    unless on_parent
      link += link_to_delete (fa_icon 'remove'), keywording, method: :delete
    end
    content_tag(:span, bootstrap_label_with_tooltip(link, type: :primary, title: keywording.keyword.description, id: "keywording-#{keywording.id}"))
  end

end
