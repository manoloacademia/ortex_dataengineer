select 	cnt.por_mes,
		cnt.cuenta,
		100 * cnt.cuenta / (sum(cuenta) OVER ()) as porcentaje
from
	(select date_trunc('month', tradedate) as por_mes, count(*) as cuenta
	from ortex
	WHERE tradedate BETWEEN '2017-01-01' and '2017-12-31'
	and tradesignificance = 3
	GROUP by date_trunc('month', tradedate)
	order by date_trunc('month', tradedate) ASC) as cnt;