class AddWeekNumberAndYearToKeywordUsages < ActiveRecord::Migration
  def change
    add_column :keyword_usages, :week_number, :integer
    add_column :keyword_usages, :year, :integer
  end
end
