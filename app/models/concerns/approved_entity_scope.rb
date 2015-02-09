module ApprovedEntityScope
  extend ActiveSupport::Concern

  included do
    scope :from_approved, -> { joins(:entity).where('entities.approved' => true) }
  end
end
