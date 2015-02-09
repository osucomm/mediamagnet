module TagsHelper
 def tag_labels(tags)
    Array(tags).map do |tag|
      bootstrap_label(tag.name, :default)
    end.join(' ').html_safe
 end
end
