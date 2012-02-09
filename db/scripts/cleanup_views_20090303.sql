use broker;
drop table temp_mae_index;
drop table temp_debt_consolidation;
drop table view_mae_regional_network;
drop table view_new_client;
drop table view_top_zip_code;
drop table view_total_household_consumer_debt;
drop table view_total_loan;
drop table view_transactions_trend;

create or replace view view_mae_regional_network as
SELECT avg(loan_amount_in_cents) as mae_regional_network, person.state as state, loan.user_id, count(*) as total_loans,
(count(distinct borrower_person_id)/count(*)*100) as total_clients
FROM loan 
inner JOIN person ON loan.borrower_person_id = person.id
WHERE loan.closing_date >= DATE_ADD( current_date, INTERVAL -180 DAY )
AND loan.closing_date <= current_date
group by person.state;

create or replace view view_avg_loan_size as
SELECT l1.user_id, avg(loan_amount_in_cents) AS avg_loan_amount ,
(SELECT avg(loan_amount_in_cents) FROM loan l2
WHERE l2.closing_date >= DATE_ADD( current_date, INTERVAL -365 DAY )
AND l2.closing_date <= current_date AND l1.user_id = l2.user_id
GROUP BY l2.user_id) AS avg_amount_in_last_year,
 (SELECT avg(loan_amount_in_cents) FROM loan l3
 WHERE l3.closing_date >= DATE_ADD( current_date, INTERVAL -180 DAY )
AND l3.closing_date <= current_date and l1.user_id = l3.user_id
GROUP BY l3.user_id
) AS avg_amount_in_last_hyear,
(SELECT view_mae_regional_network.mae_regional_network
FROM view_mae_regional_network
INNER JOIN user ON user.state = view_mae_regional_network.state where view_mae_regional_network.user_id = l1.user_id limit 1) as mae_regional_network
FROM loan l1
GROUP BY user_id;

create or replace view view_new_client as
SELECT l1.user_id, (count(distinct borrower_person_id)/count(*)*100) AS new_clients ,
(SELECT (count(distinct borrower_person_id)/count(*)*100) FROM loan l2
WHERE l2.closing_date >= DATE_ADD( current_date, INTERVAL -365 DAY )
AND l2.closing_date <= current_date AND l1.user_id = l2.user_id
GROUP BY l2.user_id) AS new_clients_last_year,
 (SELECT (count(distinct borrower_person_id)/count(*)*100) FROM loan l3
 WHERE l3.closing_date >= DATE_ADD( current_date, INTERVAL -180 DAY )
AND l3.closing_date <= current_date and l1.user_id = l3.user_id
GROUP BY l3.user_id
) AS new_clients_last_hyear,
(SELECT view_mae_regional_network.total_clients
FROM view_mae_regional_network
INNER JOIN user ON user.state = view_mae_regional_network.state where view_mae_regional_network.user_id = l1.user_id limit 1) as mae_regional_network
FROM loan l1
GROUP BY user_id;

create or replace view view_top_zip_code as 
SELECT loan.user_id, count( * ) AS no_of_borrowers, person.zip
FROM loan
INNER JOIN person ON loan.borrower_person_id = person.id
WHERE loan.closing_date >= DATE_ADD( current_date, INTERVAL -365
DAY )
AND loan.closing_date <= current_date
GROUP BY zip
ORDER BY no_of_borrowers DESC;

create or replace view view_total_household_consumer_debt as
select household.id as household_id, sum(creditor.unpaid_balance_in_cents) as unpaid_balance_in_cents
from household
inner join property on property.household_id = household.id
inner join loan on loan.property_id = property.id
inner join creditor on creditor.loan_id = loan.id
where creditor.creditor_type in ('L', 'R')
group by household.id;


create or replace view view_total_loan as 
SELECT l1.user_id, count(*) AS total_loans ,
(SELECT count(*) FROM loan l2
WHERE l2.closing_date >= DATE_ADD( current_date, INTERVAL -365 DAY )
AND l2.closing_date <= current_date AND l1.user_id = l2.user_id
GROUP BY l2.user_id) AS total_loans_last_year,
 (SELECT count(*) FROM loan l3
 WHERE l3.closing_date >= DATE_ADD( current_date, INTERVAL -180 DAY )
AND l3.closing_date <= current_date and l1.user_id = l3.user_id
GROUP BY l3.user_id
) AS loans_in_last_hyear,
(SELECT view_mae_regional_network.total_loans
FROM view_mae_regional_network
INNER JOIN user ON user.state = view_mae_regional_network.state where view_mae_regional_network.user_id = l1.user_id limit 1) as mae_regional_network
FROM loan l1
GROUP BY user_id;

CREATE OR REPLACE VIEW view_transactions_trend AS
   SELECT user_id, count( * ) AS closed_loan_count,
   concat( monthname( closing_date ) , ' - ', date_format(
   closing_date, '%y' ) ) AS period
   FROM loan
   inner join loan_status on loan.loan_status_id = loan_status.id
   and status_name = 'Closed'
   GROUP BY user_id, Year( closing_date ) , Month( closing_date )
   ORDER BY closing_date;

