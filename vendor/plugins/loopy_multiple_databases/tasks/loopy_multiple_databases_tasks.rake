Rake.send(:abort, "please install Loopy::RakeExtensions::AliasTaskChain." ) unless ( Loopy::RakeExtensions::AliasTaskChain rescue nil )

namespace :db do
  namespace :schema do
    desc "ensures that the correct schema files are written."
    task :set_schema_name do
      ENV['SCHEMA'] = "db/#{ RAILS_ENV }_schema.rb" unless RAILS_ENV =~ Loopy::MultipleDatabases::STANDARD_DB
    end
    
    task :dump => :set_schema_name
    task :load => :set_schema_name
  end
  
  namespace :test do
    desc "overrides calls to ['test'] in such a way that if RAILS_ENV=special_test, special_test is the target."
    task :replace_test_database do
      Loopy::MultipleDatabases.apply_task_patch!
    end
    
    task :clone_structure => :replace_test_database
    task :purge => :replace_test_database
    task :prepare => :replace_test_database
    
    desc "clones other databases. looks for subdirectories in db/migrate to determine this. calls normal migrate, setting the appropriate environment each time. "
    task :clone_with_other_databases => :environment do
      puts "Cloning #{ RAILS_ENV }...\n\n"
      puts %x{ rake db:test:clone_without_other_databases }

      for database in Loopy::MultipleDatabases.find_databases do
        all, matching_db, *mop = *RAILS_ENV.match(Loopy::MultipleDatabases::ANY_DB)
        unless matching_db.blank?
          target_environment = "#{ database }_#{ matching_db }"
          puts "Cloning #{ database }...\n\n"
          puts %x{ rake db:test:clone_without_other_databases RAILS_ENV=#{ target_environment } }
        end
      end
    end
    
    alias_task_chain :clone, :other_databases
  end
  
  desc "migrates other databases. looks for subdirectories in db/migrate to determine this. calls normal migrate, setting the appropriate environment each time. "
  task :migrate_with_other_databases => :environment do
    puts "Migrating #{ RAILS_ENV }...\n\n"
    puts %x{ rake db:migrate_without_other_databases }
    
    for database in Loopy::MultipleDatabases.find_databases do
      all, matching_db, *mop = *RAILS_ENV.match(Loopy::MultipleDatabases::ANY_DB)
      unless matching_db.blank?
        target_environment = "#{ database }_#{ matching_db }"
        puts "Migrating #{ database }...\n\n"
        puts %x{ rake db:migrate_without_other_databases RAILS_ENV=#{ target_environment } }
      end
    end
  end
  
  alias_task_chain :migrate, :other_databases
end