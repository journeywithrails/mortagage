module Loopy
  module MultipleDatabases
    STANDARD_DB = /^production$|^development$|^test$/
    ALTERNATIVE_DB = /^(.*)_(production|development|test)$/
    ANY_DB = /(production|development|test)$/
    
    def self.apply_task_patch!
      class << ::ActiveRecord::Base.configurations
        include Loopy::MultipleDatabases::TaskPatches
      end
    end
    
    def self.find_databases
      Dir["#{  File.join(RAILS_ROOT, 'db', 'migrate') }/*"].select { |e| File.directory?(e) }.map { |e| e.split("/").last }
    end

    def self.migrations_subdirectory
      all, alternative, *mop = *RAILS_ENV.match(ALTERNATIVE_DB)
      target = self.find_databases.select { |db| db == alternative }
      target.blank? ? nil : "db/migrate/#{ target }"
    end
    
    # overrides calls to ['test'] in such a way that if RAILS_ENV=special_test, special_test
    # is used as a key instead. this only happens if RAILS_ENV =~ /test/.
    module TaskPatches
      def self.included(base)
        base.send :alias_method, :select_without_override_test_key, :[]
        base.send :alias_method, :[], :select_with_override_test_key
      end
      
      def select_with_override_test_key(key)
        all, alternative, *mop = *RAILS_ENV.match(Loopy::MultipleDatabases::ALTERNATIVE_DB)
        key = "#{ alternative }_test" unless alternative.blank?
        select_without_override_test_key(key)
      end
    end
    
    # changes the Migrator to grab migrations from db/migrate/<your_db> when requested.
    module MigratorPatches
      def self.included(base)
        base.extend ClassMethods
        base.send :alias_method_chain, :initialize, :override_migration_path_for_test
        class << base
          alias_method_chain :migrate, :override_migration_path_for_test
        end
      end
      
      def initialize_with_override_migration_path_for_test(direction, migrations_path, target_version = nil)
        migrations_path = Loopy::MultipleDatabases.migrations_subdirectory if Loopy::MultipleDatabases.migrations_subdirectory
        initialize_without_override_migration_path_for_test(direction, migrations_path, target_version = nil)
      end
      
      module ClassMethods
        def migrate_with_override_migration_path_for_test(*args, &block)
          args[0] = Loopy::MultipleDatabases.migrations_subdirectory if Loopy::MultipleDatabases.migrations_subdirectory
          migrate_without_override_migration_path_for_test(args, block)
        end
      end
    end
  end
end

# the task patches are only applied for :clone, :clone_structure, :purge and :prepare db:test tasks. see tasks.
::ActiveRecord::Migrator.send :include, Loopy::MultipleDatabases::MigratorPatches