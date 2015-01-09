class Tag < ActiveRecord::Base
  include LowercaseName
  has_many :taggings, dependent: :destroy
  has_many :items, through: :taggings
  has_one :keyword, foreign_key: :name, primary_key: :name

  validate :name, unique: true

  class << self
    def create_from_text(text)
      self.where(name: text.downcase).first_or_create
    end

    def help_text
      <<-EOT
      Any tags found on the item when imported into Media Magnet. These tags may be 
      identical to Media Magnet keywords, or you may map tags from your 
      channels to MM keywords.
      EOT
    end
  end

end
