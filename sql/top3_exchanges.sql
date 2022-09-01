SELECT exchange, count(exchange) as total
from ortex_e
where exchange != 'off exchange'
group by exchange
order by total desc
limit 3;