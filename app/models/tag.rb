class Tag < ActiveRecord::Base
  include LowercaseName
  has_many :taggings, dependent: :destroy
  has_many :items, through: :taggings
  has_one :keyword, foreign_key: :name, primary_key: :name

  validates :name, uniqueness: true
  validates :name, presence: true

  class << self
    def create_from_text(text)
      self.where(name: taggerize(text)).first_or_create
    end

    def help_text
      <<-EOT
      Any tags found on the item when imported into Media Magnet. These tags may be 
      identical to Media Magnet keywords, or you may map tags from your 
      channels to MM keywords.
      EOT
    end

    def taggerize(text)
      text.gsub('_', '-').gsub(' ', '-').gsub(/[^0-9a-z\-]/i, '').downcase[0..30]
    end
  end

end
