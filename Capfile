require 'capitate'
require 'capitate/recipes'
set :project_root, File.dirname(__FILE__)
load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy'
