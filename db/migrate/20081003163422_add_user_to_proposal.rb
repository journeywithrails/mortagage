class AddUserToProposal < ActiveRecord::Migration
  def self.up
    execute "alter table proposal add column user_id integer unsigned not null"
    execute "update proposal set user_id = (select user_id from household where household.id = proposal.household_id)"
    execute "alter table proposal add constraint fk_proposal_user foreign key fk_proposal_user (user_id) references user (id) on delete no action on update no action"
  end

  def self.down
    execute "alter table proposal drop foreign key fk_proposal_user"
    execute "alter table proposal drop user_id"
  end
end
