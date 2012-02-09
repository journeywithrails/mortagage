require 'models/subscription'

class Subscription
  
  protected
  
    def gateway
      @gateway ||= ActiveMerchant::Billing::Base.gateway(:bogus).new
    end

end