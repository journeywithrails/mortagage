# In your migration do
# extend MigrationHelper after the class declaration
module MigrationHelper
  def add_fk(fk_table_name, pk_table_name, options = {}) 
    fk_column = options[:fk_column] || "#{pk_table_name}_id"
    pk_column = options[:pk_column] || "id"
    on_delete = options[:on_delete] || "set null"
    on_update = options[:on_update] || "cascade"

    sql = "alter table `#{fk_table_name.to_s}` add constraint  `fk_#{fk_column.to_s}_#{pk_table_name.to_s}` foreign key (`#{fk_column.to_s}`) references `#{pk_table_name.to_s}` (`#{pk_column.to_s}`) on delete #{on_delete.to_s} on update #{on_update.to_s}"
    execute sql
  end

  def drop_fk(fk_table_name, pk_table_name, options = {})
    fk_column = options[:fk_column] || "#{pk_table_name}_id"
    sql = "alter table `#{fk_table_name.to_s}` drop foreign key `fk_#{fk_column.to_s}_#{pk_table_name.to_s}`"
    execute sql
  end
end

class ActiveRecord::Migration
  extend MigrationHelper
end
