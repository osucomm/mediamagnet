class AddDefaultToTemplateColumn < ActiveRecord::Migration
  def change
    change_column :categories, :template, :boolean, :default => false
  end
end
