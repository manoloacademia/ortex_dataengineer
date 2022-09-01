select companyname, sum(valueeur) as value_eur_total 
from ortex_e
where tradedate between 20170801 and 20170831
group by companyname
order by value_eur_total DESC
limit 10;