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
      keywordable.items.each do |item| 
        item.keywords << keyword
        item.update_es_record
      end
    end
  end
  handle_asynchronously :add_keywords_to_items

  def remove_keywords_from_items
    if keywordable.respond_to?(:items)
      keywordable.items.each do |item| 
        item.remove_keyword(keyword)
        item.update_es_record
      end
    end
  end
  handle_asynchronously :remove_keywords_from_items

  def to_s
    "#{keyword.name} from #{keywordable.name}"
  end

  def week
    created_at.beginning_of_week.yesterday.beginning_of_week
  end
end
