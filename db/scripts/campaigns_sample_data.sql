insert into campaign (name, campaign_channel_id, created_at, execute_at, user_id)
values ('Winter Email', 1, '2009-03-05 11:17:17', '2009-03-15 8:00:00', 1);
set @winter_id = last_insert_id();
insert into campaign (name, campaign_channel_id, created_at, execute_at, user_id)
values ('Winter Postal', 2, '2009-02-28 16:22:44', '2009-03-15 20:00:00', 1);
insert into campaign (name, campaign_channel_id, created_at, execute_at, user_id)
values ('Large Loan Refinance', 1, '2009-03-12 11:00:22', '2009-04-01 1:00:00', 1);
set @loan_size_id = last_insert_id();
insert into campaign (name, campaign_channel_id, created_at, execute_at, user_id)
values ('College Planning Reminder', 1, '2009-05-20 11:17:17', '2009-03-15 8:00:00', 1);

insert into campaign_criteria (campaign_id, column_name, column_value)
values (@winter_id, 'mae_index_gte', '90');
insert into campaign_criteria (campaign_id, column_name, column_value)
values (@winter_id, 'pmt_savings_dollars_gte', '100');
insert into campaign_criteria (campaign_id, column_name, column_value)
values (@winter_id, 'loan_size_gte', '40000');

insert into campaign_criteria (campaign_id, column_name, column_value)
values (@loan_size_id, 'mae_index_gte', '85');
insert into campaign_criteria (campaign_id, column_name, column_value)
values (@loan_size_id, 'loan_size_gte', '500000');