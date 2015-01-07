class Keyword < ActiveRecord::Base
  include LowercaseName
  has_many :keywordings
  has_many :items, through: :keywordings, source: :keywordable, source_type: "Item"
  has_many :channels, through: :keywordings, source: :keywordable, source_type: "Channel"
  has_many :entities, through: :keywordings, source: :keywordable, source_type: "Entity"
  has_many :keyword_usages
  has_one :tag, foreign_key: :name, primary_key: :name

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

end
