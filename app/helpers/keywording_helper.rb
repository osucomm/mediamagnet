module KeywordingHelper

  def manage_keywording(keywording)
    link = link_to keywording.keyword.name, keywording.keyword
    link += ' '
    link += link_to (fa_icon 'remove'), keywording, method: :delete, data: { remote: true } 
    bootstrap_label_with_tooltip(link, type: :primary, title: keywording.keyword.description, id: "keywording-#{keywording.id}")
  end

end
