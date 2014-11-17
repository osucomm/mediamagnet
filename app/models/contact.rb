class Contact < ActiveRecord::Base
  belongs_to :contactable, polymorphic: true

  after_save :destroy_if_empty!

  def empty?
    ignored_attrs = ['id', 'created_at', 'updated_at', 'contactable_id', 'contactable_type']
    self.attributes.all?{ |k, v| v.blank? || ignored_attrs.include?(k) }
  end

  def display_name
    organization || name
  end


  private

    def destroy_if_empty!
      self.destroy if empty?
    end
end
