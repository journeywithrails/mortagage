class DropUnusedLoanViews < ActiveRecord::Migration
  def self.up
    execute "drop view if exists view_fixed_rate"
    execute "drop view if exists view_heloc"
    execute "drop view if exists view_arm"
    execute "drop table if exists view_other"
    execute "drop table if exists view_loan_type_fixed"
    execute "drop table if exists view_loan_type_heloc"
    execute "drop table if exists view_loan_type_other"
    execute "drop view if exists view_avg_loan_size"
    execute "drop table if exists view1"
    execute "drop table if exists scw_proposals"
    execute "drop table if exists tlcfico"
    execute "drop table if exists tlcloantable"
    execute "drop table if exists tlcnxtarmdate"
  end

  def self.down
  end
end
