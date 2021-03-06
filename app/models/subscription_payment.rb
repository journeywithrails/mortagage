class SubscriptionPayment < AccountModel
  belongs_to :subscription
  belongs_to :account
  
  before_create :set_account
  after_create :send_receipt
  
  def set_account
    self.account = subscription.account
  end
  
  def send_receipt
    return unless amount > 0
    if setup?
      SubscriptionNotifier.deliver_setup_receipt(self)
    else
      SubscriptionNotifier.deliver_charge_receipt(self)
    end
    true
  end  
end
