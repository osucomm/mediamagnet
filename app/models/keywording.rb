class Keywording < ActiveRecord::Base
  belongs_to :keyword
  belongs_to :keywordable, polymorphic: true
  delegate :mappings, to: :keywordable

  after_create :add_keywords_to_items
  before_destroy :remove_keywords_from_items

  scope :by_keywords, ->(keyword_ids) {
    where(keyword_id: keyword_ids)
  }

  def add_keywords_to_items
    if keywordable.respond_to?(:items)
      keywordable.items.each { |item| item.keywords << keyword }
    end
  end

  def update_keywords_on_items
    if keywordable.respond_to?(:items)
      keywordable.items.each { |item| item.remove_keyword(keyword) }
    end
  end

end
