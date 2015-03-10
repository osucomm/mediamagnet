attributes :name
node(:category) { |k| k.category.try(:name) }
