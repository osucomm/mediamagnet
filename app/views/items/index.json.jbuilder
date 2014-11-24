json.items do
  json.array! @items, partial: 'items/item', as: :item
end
json.meta do
  json.total_pages @items.total_pages
end

