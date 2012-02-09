# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

module Loopy
  module RakeExtensions
    module AliasTaskChain
      def alias_task_chain(enhancable_task, feature)
        original_name = Rake.application.current_scope.empty? ? 
          target_task : ( Rake.application.current_scope << enhancable_task ).join(":")
        chained_orignal_name = "#{ original_name }_without_#{ feature }"
        chained_enhanced_name = "#{ enhancable_task }_with_#{ feature }"
        target_task = Rake::Task[original_name]
       tasks = Rake.application.send(:eval, "@tasks")
        target_task.instance_variable_set("@name", chained_orignal_name)
        tasks.delete(original_name)
       tasks[chained_orignal_name] = target_task
        task enhancable_task => chained_enhanced_name
      end
    end
  end
end

send :include, Loopy::RakeExtensions::AliasTaskChain

require 'tasks/rails'
