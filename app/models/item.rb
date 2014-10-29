class Item < ActiveRecord::Base
  belongs_to :channel
  has_one :entity, through: :channel
  has_many :assets
  has_and_belongs_to_many :keywords
  has_and_belongs_to_many :tags

  validates :guid, presence: :true

  def to_s
    [:title, :description, :guid].each do |field|
      return self.send(field) unless self.send(field).blank?
    end
  end

end
