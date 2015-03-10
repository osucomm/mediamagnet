node (:meta) do
  meta(@items).merge(response_code: response.code.to_i)
end
child (@items) do
  extends 'api/v1/items/_item'
end
