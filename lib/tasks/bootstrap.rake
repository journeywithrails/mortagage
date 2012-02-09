namespace :db do
  desc 'Load an initial set of data'
  task :bootstrap => :environment do
    Rake::Task["db:schema:load"].invoke
    plans = [
      { 'name' => 'Free', 'amount' => 0, 'user_limit' => 2 },
      { 'name' => 'Basic', 'amount' => 10, 'user_limit' => 5 },
      { 'name' => 'Premium', 'amount' => 30, 'user_limit' => nil }
    ].collect do |plan|
      SubscriptionPlan.create(plan)
    end
    user = User.new(:name => 'Test', :login => 'test', :password => 'test', :password_confirmation => 'test', :email => 'test@example.com')
    a = Account.create(:name => 'Test Account', :domain => 'localhost', :plan => plans.first, :user => user)
    a.update_attribute(:full_domain, 'localhost')
  end
end