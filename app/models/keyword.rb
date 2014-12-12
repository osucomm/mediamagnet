class Keyword < ActiveRecord::Base
  include LowercaseName
  has_many :taggings
  has_many :entities, through: :taggings, source: :taggable, source_type: "Entity"
  has_many :channels, through: :taggings, source: :taggable, source_type: "Channel"
  has_many :items, through: :taggings, source: :taggable, source_type: "Item"

  enum category: { audience: 0, college: 1, location: 2 }

  # Validations
  validates :name, presence: true
  validates :display_name, presence: true

  default_scope -> {
    order('display_name ASC')
  }

  def all_items_with_scope(item_scope)
    (items.send(item_scope) + 
     channels.map{ |c| c.items.send(item_scope) } +
     entities.map{ |c| c.items.send(item_scope) }).to_a.flatten.uniq
  end

  def all_items_this_week_for_channel(channel_id)
    Item.this_week.by_channels(channel_id).by_keywords(id)
  end

  def all_items
    all_items_with_scope(:all)
  end

  class << self
    def help_text
      <<-EOT
      Keywords are an established set of categories to help organize content.
      Items get all keywords assigned to their entities and channels, by
      having tags in their source system named identically to a keyword, or
      through mappings on channels and entities.
      EOT
    end
  end

  def item_count
    all_items.count
  end
end
