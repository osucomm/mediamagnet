object false
cache @keywords

if @keywords.present?
  child @keywords, object_root: false do
    attributes :name, :display_name, :description
    node(:category) { |k| k.category.try(:name) }
  end
else
  child @keywords => :keywords
end

node (:meta) do
  meta(@keywords)
end
