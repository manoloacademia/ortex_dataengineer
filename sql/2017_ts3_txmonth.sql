SELECT date_trunc('month', tradedate) as month, count(*) as total_transactions
FROM ortex
where tradedate BETWEEN '2017-01-01 00:00:00' and '2017-12-01 00:00:00'
and tradesignificance = 3
group by month, tradesignificance
order by month ASC;