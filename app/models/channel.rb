class Channel < ActiveRecord::Base
  # STI types
  TYPES = [TwitterChannel,InstagramChannel,WebChannel,EventChannel,FacebookChannel,YoutubeChannel]

  # Associations
  belongs_to :entity
  has_one :contact, as: :contactable
  has_many :items
  has_and_belongs_to_many :keywords
  has_and_belongs_to_many :tags

  # Validations
  validates :name, presence: true
  validates :service_identifier, presence: true

  class << self
    def type_name
      self.name.sub('Channel', '')
    end

    def policy_class
      ChannelPolicy
    end
  end

  def type_name
    self.class.type_name
  end

  def service_id_name
    'Service Identifier'
  end

end
