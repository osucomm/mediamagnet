class AddServiceIdentifierIdToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :service_identifier_id, :integer
  end
end
