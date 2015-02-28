attributes :id, :name
node(:category) { |k| k.category.try(:name) }
