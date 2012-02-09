class BrokerUser < ActiveRecord::Base
  set_table_name "user"
  
  belongs_to :account, :class_name => 'BrokerAccount', :foreign_key => :account_id
  belongs_to :mae_regional_network
  
  has_many :account_uploads, :class_name => 'AccountUpload', :foreign_key => :user_id
  has_many :households, :class_name => 'Household', :foreign_key => :user_id
  has_many :jobs, :class_name => 'Job', :foreign_key => :user_id
  has_many :loans, :class_name => 'Loan', :foreign_key => :user_id
  has_many :proposals, :foreign_key => :user_id
  has_many :household_reports, :foreign_key => :user_id
  has_many :campaigns, :class_name => 'Campaign', :foreign_key => :user_id
  has_many :proposal_scenarios, :through => :proposals

  has_many :recent_proposals, :class_name => "Proposal", :foreign_key => :user_id, :order => "updated_at desc"
  has_many :recent_adhoc_reports, :class_name => "HouseholdReport", :foreign_key => :user_id, :order => "created_at desc", :conditions =>"campaign_id is null"
  has_many :recent_campaign_reports, :class_name => "HouseholdReport", :foreign_key => :user_id, :order => "created_at desc", :conditions =>"campaign_id is not null"

  # latest_campaign is the latest campaign that was executed (not campaigns in the future)
  has_one :latest_campaign, :class_name => 'Campaign', :foreign_key => :user_id, :conditions => ["execute_at < ?", Time.now], :order => 'execute_at desc'
  has_one :latest_upload, :class_name => 'AccountUpload', :foreign_key => :user_id, :conditions => "upload_status_id = 4", :order => 'upload_date_time desc'

  validates_presence_of :email
  validates_length_of :email, :allow_nil => false, :maximum => 200
  
  def to_label
    "#{email}"
  end

  def new_opportunity_count
    households.count(:conditions => "best_mae_index > 60 and is_dirty = 0")
  end

  def properties_for_sale(options={})
    options.merge! \
      :conditions => "household.user_id = #{id}",
      :joins => "inner join property on property_for_sale.property_id = property.id " +
                "inner join household on property.household_id = household.id "

    PropertyForSale.find(:all, options)
  end

end
