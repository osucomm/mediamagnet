module KeywordingHelper

  def manage_keywording(keywording)
    link = link_to keywording.keyword.name, keywording.keyword
    link += ' '
    link += link_to_delete (fa_icon 'remove'), keywording, method: :delete
    bootstrap_label_with_tooltip(link, type: :primary, title: keywording.keyword.description, id: "keywording-#{keywording.id}")
  end

end
