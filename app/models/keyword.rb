class Keyword < ActiveRecord::Base
  include LowercaseName
  has_many :taggings
  has_many :channels, through: :taggings, source: :taggable, source_type: "Channel"
  has_many :items, through: :taggings, source: :taggable, source_type: "Item"

  enum category: { audience: 0, college: 1, location: 2 }

  # Validations
  validates :name, presence: true
  validates :display_name, presence: true

  default_scope -> {
    order('display_name ASC')
  }

  class << self
    def help_text
      'Keywords are important.'
    end
  end

  def item_count
    items.count
  end
end
