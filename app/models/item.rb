class Item < ActiveRecord::Base
  belongs_to :channel
  has_one :entity, through: :channel
  has_many :assets
  has_and_belongs_to_many :keywords
  has_and_belongs_to_many :tags

  validates :guid, presence: :true
  validates :channel_id, presence: :true

  def to_s
    [:title, :description, :guid].each do |field|
      return self.send(field) unless self.send(field).blank?
    end
  end

  def add_keywords(new_keywords)
    new_keywords.each do |keyword_text|
      if keyword = Keyword.where(name: keyword_text).first
        keywords << keyword
      end
    end
  end

  def link
    if attributes['link'].blank?
      channel.link_for(self)
    else
      attributes['link']
    end

  end

end
