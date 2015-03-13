class Api::V1::ChannelsController < Api::BaseController
  has_scope :by_type

  def index
    @channels = apply_scopes(Channel).all.from_approved
      .includes(:keywords)
      .page(params[:page])
      .per(params[:per_page])
  end

  def show
    @channel = Channel
      .includes(:keywords, :entity, :mappings, :contact, :mapped_tags, :mapped_keywords)
      .find(params[:id])
  end

end
