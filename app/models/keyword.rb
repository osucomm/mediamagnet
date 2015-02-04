class Keyword < ActiveRecord::Base
  include LowercaseName

  SPECIAL_KEYWORD_PATTERNS = ::Regexp.union([ 
    /course-[A-Za-z]+-[0-9]+/,
    /department-[0-9]{,5}/,
    /person-[A-Za-z\-]\.[0-9]+/
  ])

  has_many :keywordings, dependent: :destroy
  has_many :items, -> { uniq }, through: :keywordings, source: :keywordable, source_type: "Item"
  has_many :channels, through: :keywordings, source: :keywordable, source_type: "Channel"
  has_many :entities, through: :keywordings, source: :keywordable, source_type: "Entity"
  has_many :keyword_usages, dependent: :destroy
  has_one :tag, foreign_key: :name, primary_key: :name
  belongs_to :category

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

    def special_keyword?(tag_name)
      SPECIAL_KEYWORD_PATTERNS =~ tag_name
    end

    def valid_keyword?(tag_name)
      where(name: tag_name).any? || special_keyword?(tag_name)
    end

    def normal
      templated_categories = Category.where(template: true)
      where('category_id not in (?)', templated_categories.map(&:id))
    end

  end

end
