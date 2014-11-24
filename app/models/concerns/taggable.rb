module Taggable
  extend ActiveSupport::Concern

  included do
    has_many :taggings, as: :taggable, dependent: :destroy
    has_many :tags, through: :taggings
    has_many :keywords, through: :taggings

    def tag_names=(new_tags)
      new_tags = [] if new_tags.nil?
      new_tags.map!(&:downcase)
      existing_tags = tags.map(&:name)

      (new_tags - existing_tags).each do |tag_text|
        taggings.build(tag_text: tag_text)
      end

      save!

      taggings.joins(:tag).where("tags.name IN (?)", (existing_tags - new_tags)).destroy_all

      reload
      return (new_tags - existing_tags)
    end

  end
end
