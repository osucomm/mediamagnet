class Keywording < ActiveRecord::Base
  belongs_to :keyword
  belongs_to :keywordable, polymorphic: true
  delegate :mappings, to: :keywordable

  after_create :add_keywords_to_items, if: :keywordable_not_item
  before_destroy :remove_keywords_from_items, if: :keywordable_not_item

  scope :by_keywords, ->(keyword_ids) {
    where(keyword_id: keyword_ids)
  }

  def keywordable_not_item
    keywordable.respond_to?(:items)
  end

  def add_keywords_to_items
    if keywordable_not_item
      keywordable.items.each do |item| 
        item.keywords << keyword
        item.update_es_record
      end
    end
  end

  def remove_keywords_from_items
    if keywordable_not_item
      keywordable.items.each do |item| 
        item.remove_keyword(keyword)
        item.update_es_record
      end
    end
  end

  def to_s
    "#{keyword.name} from #{keywordable.name}"
  end

  def week
    created_at.beginning_of_week.yesterday.beginning_of_week
  end
end
