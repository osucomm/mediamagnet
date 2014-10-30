json.total_pages @items.total_pages

json.items do
  json.array! @items, partial: 'items/item', as: :item
end
