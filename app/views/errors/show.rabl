object root: { root: 'result' } if request.format.xml?

child @error, object_root: false do
  attributes :status, :message, :errors
end
