class CreateKeywordings < ActiveRecord::Migration
  def change
    create_table :keywordings do |t|
      t.string :keywordable_type
      t.integer :keywordable_id
      t.integer :keyword_id

      t.timestamps
    end
  end
end
