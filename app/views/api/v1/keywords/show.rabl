cache @keyword
object @keyword => :items

attributes :id, :name, :description, :category
node(:category) { |i| i.category_name }
