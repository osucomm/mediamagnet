class CreateKeywordUsages < ActiveRecord::Migration
  def change
    create_table :keyword_usages do |t|
      t.references :keyword, index: true
      t.references :channel, index: true
      t.integer :count
      t.datetime :starts_at
      t.datetime :ends_at
    end
  end
end
