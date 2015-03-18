object root: { root: 'result' } if request.format.xml?
cache @keywords

if @keywords.present?
  child @keywords, object_root: false do
    extends 'api/v1/keywords/_keyword'
    attributes :display_name, :description
  end
else
  child @keywords => :keywords
end

node (:meta) do
  meta(@keywords)
end
