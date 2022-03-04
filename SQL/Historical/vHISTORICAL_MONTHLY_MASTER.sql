-- ===========================================
-- Author:		Kevin Corcoran
-- Updated:     01/25/2022
-- Description:	vHISTORICAL_MONTHLY_MASTER
-- QA 
-- ===========================================
-- DROP VIEW "HISTORICAL"."vHISTORICAL_MONTHLY_MASTER";

--CREATE OR REPLACE VIEW "HISTORICAL"."vHISTORICAL_MONTHLY_MASTER"
--AS 
SELECT 
	t1.fk_monthly,
	t1.fk_yearly,
	t1.ticker,
	t1."year",
	t1."month",
	t1.startdate,
	t1.enddate,
	round(t2.open, 2) AS "open",
	round(t1.high, 2) AS high,
	round(t1.low, 2) AS low,
	round(t3.close, 2) AS "close",
	round(t1.volume, 0) AS volume
	--,*
 FROM (
	SELECT 
	 	CONCAT(ticker, '_' ,EXTRACT (year FROM "date"),'_', EXTRACT (month FROM "date")) AS fk_monthly,
		CONCAT(ticker,'_' ,EXTRACT (year FROM "date")) AS fk_yearly,
		ticker,
		EXTRACT (year from "date") AS "year",
		EXTRACT (month from "date") AS "month",
		MIN("date") AS startdate,
		MAX("date") AS enddate,
		round(MAX(high), 2)  AS high,
	 	round(MIN(low), 2) AS low,
		round(SUM(volume), 0) AS volume
	 FROM "HISTORICAL"."HISTORICAL_DAILY_MASTER" 
	GROUP BY "year", ticker, "month"
	--ORDER BY ticker ASC, "year" DESC, "month" DESC 
 	) t1

LEFT JOIN "HISTORICAL"."HISTORICAL_DAILY_MASTER" t2
ON t1.startdate = t2."date" AND t1.ticker = t2.ticker
LEFT JOIN "HISTORICAL"."HISTORICAL_DAILY_MASTER" t3
ON t1.enddate = t3."date" AND t1.ticker = t3.ticker
--WHERE startdate = enddate

order by year desc
--order by fk_monthly 
;

--WHERE "PK" LIKE 'GOOG_2011%'
--ORDER BY ticker ASC, "year" DESC, "month" DESC 

--ALTER TABLE "HISTORICAL"."vHISTORICAL_MONTHLY_MASTER"
--    OWNER TO postgres;



