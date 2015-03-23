class MigrateToUnicode < ActiveRecord::Migration
  def up
    alter_database_and_tables_charsets 'utf8mb4', 'utf8mb4_unicode_ci'
  end

  def down
    alter_database_and_tables_charsets
  end


  private

  def alter_database_and_tables_charsets charset = default_charset, collation = default_collation
    case connection.adapter_name
    when 'MySQL'
      execute "ALTER DATABASE #{connection.current_database} CHARACTER SET #{charset} COLLATE #{collation}"

      connection.tables.each do |table|
        execute "ALTER TABLE #{table} CONVERT TO CHARACTER SET #{charset} COLLATE #{collation}"
      end
    else
      say "#{connection.adapter_name} not supported for Unicode conversion. Ensure your database supports Unicode characters!"
    end
  end

  def default_charset
    case connection.adapter_name
    when 'MySQL'
      execute("show variables like 'character_set_server'").fetch_hash['Value']
    else
      nil
    end
  end

  def default_collation
    case connection.adapter_name
    when 'MySQL'
      execute("show variables like 'collation_server'").fetch_hash['Value']
    else
      nil
    end
  end

  def connection
    ActiveRecord::Base.connection
  end
end
