require 'models/subscription'

class Subscription
  
  protected
  
    def gateway
      @gateway ||= ActiveMerchant::Billing::Base.gateway(:brain_tree).new(
        :login => 'demo', :password => 'password')
    end

end