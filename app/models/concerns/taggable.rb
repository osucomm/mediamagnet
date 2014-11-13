module Taggable
  extend ActiveSupport::Concern

  included do
    has_many :taggings, as: :taggable
    has_many :tags, through: :taggings
    has_many :keywords, through: :taggings

    def tags=(new_tags)
      new_tags = [] if new_tags.nil?
      existing_tags = tags.map(&:name)

      (new_tags - existing_tags).each do |tag_text|
        taggings.create(tag_text: tag_text)
      end

      taggings.joins(:tag).where("tags.name IN (?)", (existing_tags - new_tags)).destroy_all
      
      reload
      return (new_tags - existing_tags)
    end

  end
end