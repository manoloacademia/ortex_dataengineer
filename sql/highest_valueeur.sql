select companyname, sum(valueeur) as highest
from ortex
where tradedate BETWEEN '2017-08-01' and '2017-08-31'
GROUP by companyname
order by highest DESC
limit 2;