class CreateViewLatestPersonFinancial < ActiveRecord::Migration
  def self.up
    execute "create or replace view view_latest_person_financial as
select * from person_financial  where id in
(select max(id) from person_financial group by person_id)"
  end

  def self.down
  end
end
