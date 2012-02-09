class Common::ProposalController < ApplicationController
  def initialize
    super
    self.subtab_nav = 'new_loan'
  end

  active_scaffold :proposal do |config|
    config.columns = [:name, :household, :property, :proposal_scenarios, :updated_at]
#    config.columns[:property].includes = nil
    
    config.columns[:proposal_scenarios].label = "scenarios"
#    config.columns[:property].label = "properties"
    
    list.sorting = {:updated_at => :desc}
    
    config.actions = [:list] 
    # , :delete

    # note: link to proposal in helpers/common/proposal_controller_helper
  end

  def conditions_for_collection
    ['proposal.user_id = ?', current_broker_user.id]
  end
  
  def list
    session[:proposal_id] = nil
    super   
  end
end
