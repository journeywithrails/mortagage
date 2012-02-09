class SubscriptionNotifier < ActionMailer::Base
  include ActionView::Helpers::NumberHelper
  
  def setup_email(to, subject, from = AppConfig['from_email'])
    @sent_on = Time.now
    @subject = subject
    @recipients = to.respond_to?(:email) ? to.email : to
    @from = from.respond_to?(:email) ? from.email : from
  end
  
  def welcome(account)
    setup_email(account.admin, "Welcome to #{AppConfig['app_name']}!")
    @body = { :account => account }
  end
  
  def trial_expiring(user, subscription)
    setup_email(user, 'Trial period expiring')
    @body = { :user => user, :subscription => subscription }
  end
  
  def charge_receipt(subscription_payment)
    setup_email(subscription_payment.subscription.account.admin, "Your #{AppConfig['app_name']} invoice")
    @body = { :subscription => subscription_payment.subscription, :amount => subscription_payment.amount }
  end
  
  def setup_receipt(subscription_payment)
    setup_email(subscription_payment.subscription.account.admin, "Your #{AppConfig['app_name']} invoice")
    @body = { :subscription => subscription_payment.subscription, :amount => subscription_payment.amount }
  end
  
  def charge_failure(subscription)
    setup_email(subscription.account.admin, "Your #{AppConfig['app_name']} renewal failed")
    @bcc = AppConfig['from_email']
    @body = { :subscription => subscription }    
  end
  
  def plan_changed(subscription)
    setup_email(subscription.account.admin, "Your #{AppConfig['app_name']} plan has been changed")
    @body = { :subscription => subscription }    
  end
  
  def reset_password(to, new_password)
    setup_email(to, "Password reset request for Mortgage Science")
    domain = ''
    user = User.find_by_email(to)
    domain = user.account.full_domain if user
    @body = {:new_password => new_password, :domain => domain}
  end  
  
  def password_reset(reset)
    setup_email(reset.user, 'Password Reset Request')
    @body = { :reset => reset }
  end
end
