
	------------------ Leetcode.com -----------------------
	
	-- 1193. Monthly Transactions
	
/* Write an SQL query to find for each month and country, the number of transactions and their total amount, 
   the number of approved transactions and their total amount. */
	
	With TotalTransaction as (
    Select  date_format(trans_date, '%Y-%m') as month, country,
    count(id) as trans_count, sum(amount) as trans_total_amount
    From Transactions
    Group by month, country
),

	ApprovedTransactions as (

	Select  date_format(trans_date, '%Y-%m') as month, country,
	count(id) as approved_count, sum(amount) as approved_total_amount
	From Transactions
	Where state = 'approved'
	Group by month, country

)

	Select T.month, T.country, T.trans_count, A.approved_count,
	T.trans_total_amount, A.approved_total_amount
	From TotalTransaction as T
	Inner Join 
	ApprovedTransactions A
	On T.month = A.month and T.country = A.country;