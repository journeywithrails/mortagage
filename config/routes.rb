ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "home"

  # See how all your routes lay out with "rake routes"
  map.resource :home, :controller => 'home', :collection => { :services => :get }
  map.plans '/signup', :controller => 'accounts', :action => 'plans'
  map.thanks '/signup/thanks', :controller => 'accounts', :action => 'thanks'
  map.resource :account, :collection => { :dashboard => :get, :thanks => :get, :plans => :get, :billing => :any, :plan => :any, :cancel => :any, :canceled => :get }
  map.new_account '/signup/:plan', :controller => 'accounts', :action => 'new', :plan => nil
  
  map.resources :users, :collection => { :forgot_password => :get }, :member => { :forgot_password => :post}
  map.resources :users
  map.resource :session
  map.resource :opportunity, :controller => 'opportunity'
  map.resource :portfolio, :controller => 'portfolio'
  map.resource :network, :controller => 'network'
  map.resource :admin, :controller =>'admin'
  map.resource :campaigns, :controller =>'campaigns'
  map.resources :reports, :controller => 'reports', :active_scaffold => true, :collection => {:refinance => :post}
  
  map.get_tax_rate 'tax_rate/get', :controller => 'common/tax_rate', :action => 'get', :conditions => {:method => :post}
  #  map.resource :file_upload, :controller => 'file_upload'
  
  map.namespace :admin do |adm|
    adm.resources :household, :active_scaffold=>true
    adm.resources :loan, :active_scaffold=>true
    adm.resources :property, :active_scaffold=>true
    adm.resources :person, :active_scaffold=>true
    adm.resources :proposal, :active_scaffold=>true
    adm.resources :rate, :active_scaffold=>true
    adm.resources :tax_filing_status, :active_scaffold=>true
    adm.resources :account, :active_scaffold=>true
    adm.resources :account_upload, :active_scaffold=>true
    adm.resources :job, :active_scaffold=>true
    adm.resources :server, :active_scaffold=>true
    adm.resources :global_property, :active_scaffold=>true
    adm.resources :household, :active_scaffold=>true
    
  end
  
  map.namespace :opportunity do |opp|
    opp.resource :all, :controller =>'all'
    opp.resource :refinance, :controller =>'refinance'
    opp.resource :debt, :controller =>'debt'
    opp.resource :college, :controller =>'college'
    opp.resource :retire, :controller =>'retire'
    opp.resource :invest, :controller =>'invest'
    opp.connect 'detail/:id', :controller => 'detail', :action =>'index'
    opp.resource :raterisk, :controller => 'raterisk'  
  end
  
  map.namespace :new_loan do |new_loan|
    new_loan.resources :proposals, :collection => {:do_search => :get}, :member => {:loan => :get, :update_loan => :put, :summary => :get, :comparison => :get} do |proposals|
      proposals.resources :proposal_scenarios
    end    
  end
  
  map.namespace :network do |network|
    network.resource :all, :controller =>'all'
    network.resource :search, :controller =>'search'
  end
  
   map.namespace :campaigns do |campaigns|
    campaigns.resource :wizard, :controller =>'wizard'
    campaigns.resource :campaign_types, :controller =>'campaign_types'
    campaigns.resource :wizard_criteria, :controller =>'wizard_criteria'
    campaigns.resource :campaign_types_adv, :controller =>'campaign_types_adv'
  end
  
  map.namespace :portfolio do |portfolio|
    portfolio.resource :demographics, :controller =>'demographics',:action=>'show'
    portfolio.resources :property_dashboard,:controller => 'property_dashboard'
    portfolio.resources :property_details,:controller => 'property_details'
    portfolio.resources  :view_household_loans, :as => 'households', :controller => 'view_household_loan', :collection => {:do_search => :get, :do_advanced_search => :get, :advanced_search => :get, :search_files_to_review => :get, :incomplete_files => :get}, :member => {:overview => :get}
    portfolio.resources  :household_overview,:controller => 'household_overview',:member =>{:property_dashboard => :get,:property_detail => :get}
  end
  

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

  # public content
  map.connect '*path', :controller => 'content', :action => 'show'
end
