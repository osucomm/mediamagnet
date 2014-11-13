module LowercaseName
  extend ActiveSupport::Concern

  included do
    def name=(name)
      write_attribute(:name, name.downcase)
    end
  end
end
