class Keyword < ActiveRecord::Base
  include LowercaseName
  has_many :taggings
  has_many :entities, through: :tag
  has_many :channels, through: :tag
  has_one :tag, foreign_key: :name, primary_key: :name
  has_many :items, through: :tag
  has_many :keyword_usages

  enum category: { audience: 0, college: 1, location: 2, format: 3 }

  # Validations
  validates :name, presence: true
  validates :display_name, presence: true

  default_scope -> {
    order('display_name ASC')
  }

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

  def all_items
    #TODO Get all items
  end

  def item_count
    all_items.count
  end

end
