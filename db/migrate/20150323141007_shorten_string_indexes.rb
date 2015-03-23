class ShortenStringIndexes < ActiveRecord::Migration
  def up
    remove_index :channels, :type
    add_index :channels, :type, length: 191

    remove_index :contacts, [:contactable_id, :contactable_type]
    add_index :contacts, [:contactable_id, :contactable_type], length: {contactable_type: 191}

    remove_index :keywordings, [:keywordable_id, :keywordable_type]
    add_index :keywordings, [:keywordable_id, :keywordable_type], length: {keywordable_type: 191}

    remove_index :keywords, :name
    add_index :keywords, :name, length: 191

    remove_index :mappings, :type
    add_index :mappings, :type, length: 191

    remove_index :users, :email
    add_index :users, :email, unique: true, length: 191
  end

  def down
    remove_index :channels, :type
    add_index :channels, :type

    remove_index :contacts, [:contactable_id, :contactable_type]
    add_index :contacts, [:contactable_id, :contactable_type]

    remove_index :keywordings, [:keywordable_id, :keywordable_type]
    add_index :keywordings, [:keywordable_id, :keywordable_type]

    remove_index :keywords, :name
    add_index :keywords, :name

    remove_index :mappings, :type
    add_index :mappings, :type

    remove_index :users, :email
    add_index :users, :email, unique: true
  end
end
