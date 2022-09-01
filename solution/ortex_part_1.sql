-- The following file, answers the Ortex Data Engineer Programming Exercise PART 1
-- My name is Pablo Segovia! Thank you for your time and the opportunity to submit my proposals to this exercise

-- Table: public.ortex

-- DROP TABLE IF EXISTS public.ortex;

CREATE TABLE IF NOT EXISTS public.ortex
(
    transactionid integer NOT NULL,
    gvkey integer,
    companyname character varying(128),
    companyisin character varying(128),
    companysedol character varying(128),
    insiderid integer,
    insidername character varying(128),
    insiderrelation character varying(128),
    insiderlevel character varying(128),
    connectiontype character varying(128),
    connectedinsidername character varying(128),
    connectedinsiderposition character varying(128),
    transactiontype character varying(128),
    transactionlabel character varying(128),
    iid character varying(128),
    securityisin character varying(128),
    securitysedol character varying(128),
    securitydisplay character varying(128),
    assetclass character varying(128),
    shares double precision,
    inputdate integer,
    tradedate date,
    maxtradedate double precision,
    price double precision,
    maxprice double precision,
    value double precision,
    currency character varying(128),
    valueeur double precision,
    unit character varying(128),
    correctedtransactionid double precision,
    source character varying(128),
    tradesignificance integer,
    holdings double precision,
    filingurl character varying(256),
    exchange character varying(128)
    PRIMARY KEY (transactionid)
);

-- Task 0: populate the table with 2017.csv file
COPY ortex
FROM 'C:\ortex\2017.csv' 
DELIMITER ',' 
CSV HEADER;

-- Another way is to use PgAdmin 4, right click on ortex table and choose option "Import/Export Data"

-- Task 1: Which are the top three exchange with the most transactions in the file?
SELECT exchange, count(*) as total
from ortex
where exchange != 'off exchange'
group by exchange
order by total desc
limit 3;

-- Answer:
    -- 1st: LSE(UK)
    -- 2nd: Euronext Paris (France)
    -- 3rd: Istanbul (Turkey)


-- Task 2: In August 2017, which 2 companyNames had the highest combined valueEur?
select companyname, sum(valueeur) as highest
from ortex
where tradedate BETWEEN '2017-08-01' and '2017-08-31'
GROUP by companyname
order by highest DESC
limit 2;

-- Answer:
    -- 1st: HSBC HLDGS PLC
    -- 2nd: EUROSIC SA

-- Task 3: For 2017, only considering transactions with tradeSignificance 3, what is the percentage of transactions per month?
select 	cnt.per_month,
		cnt.total,
		100 * cnt.total / (sum(total) OVER ()) as percentage
from
	(select date_trunc('month', tradedate) as per_month, count(*) as total
	from ortex
	WHERE tradedate BETWEEN '2017-01-01' and '2017-12-31'
	and tradesignificance = 3
	GROUP by date_trunc('month', tradedate)
	order by date_trunc('month', tradedate) ASC) as cnt;

-- Answer:
    -- | per_month | percentage |
    ------------------------------
    -- | January   | 7.62       |
    -- | February  | 8.42       |
    -- | March     | 12.67      |
    -- | April     | 7.27       |
    -- | May       | 10.98      |
    -- | June      | 1.09       |
    -- | July      | 0.40       |
    -- | August    | 8.78       |
    -- | September | 12.59      |
    -- | October   | 10.01      |
    -- | November  | 11.23      |
    -- | December  | 8.96       |