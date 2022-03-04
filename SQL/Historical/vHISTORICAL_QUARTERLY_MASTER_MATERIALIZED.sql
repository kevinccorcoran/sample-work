-- ===========================================
-- Author:		Kevin Corcoran
-- Description:	vHISTORICAL_QUARTERLY_MASTER_MATERIALIZED
-- QA 
-- Feb 17 th created
-- ===========================================

CREATE MATERIALIZED VIEW "HISTORICAL"."vHISTORICAL_QUARTERLY_MASTER_MATERIALIZED"
AS
SELECT
	CASE
		WHEN right(pk_quarter, 2) = '01' THEN CONCAT(t1.ticker, '_', EXTRACT (year FROM t1."enddate") ,'_', '01' )
		WHEN right(pk_quarter, 2) = '04' THEN CONCAT(t1.ticker, '_', EXTRACT (year FROM t1."enddate") ,'_', '04' )
		WHEN right(pk_quarter, 2) = '07' THEN CONCAT(t1.ticker, '_', EXTRACT (year FROM t1."enddate") ,'_', '07' )
		WHEN right(pk_quarter, 2) = '10' THEN CONCAT(t1.ticker, '_', EXTRACT (year FROM t1."enddate") ,'_', '10' )
		WHEN right(pk_quarter, 2) = '02' THEN CONCAT(t1.ticker, '_', EXTRACT (year FROM t1."enddate") ,'_', '02' )
		WHEN right(pk_quarter, 2) = '05' THEN CONCAT(t1.ticker, '_', EXTRACT (year FROM t1."enddate") ,'_', '05' )
		WHEN right(pk_quarter, 2) = '08' THEN CONCAT(t1.ticker, '_', EXTRACT (year FROM t1."enddate") ,'_', '08' )
		WHEN right(pk_quarter, 2) = '11' THEN CONCAT(t1.ticker, '_', EXTRACT (year FROM t1."enddate") ,'_', '11' )
		WHEN right(pk_quarter, 2) = '03' THEN CONCAT(t1.ticker, '_', EXTRACT (year FROM t1."enddate") ,'_', '03' )
		WHEN right(pk_quarter, 2) = '06' THEN CONCAT(t1.ticker, '_', EXTRACT (year FROM t1."enddate") ,'_', '06' )
		WHEN right(pk_quarter, 2) = '09' THEN CONCAT(t1.ticker, '_', EXTRACT (year FROM t1."enddate") ,'_', '09' )
		WHEN right(pk_quarter, 2) = '12' THEN CONCAT(t1.ticker, '_', EXTRACT (year FROM t1."enddate") ,'_', '12' )
		
	END pk_quarter,
	t1.startdate,
	t1.enddate,
	t2.open,
	t1.high,
	t1.low,
	t3.close,
	t1.volume,
	t1.ticker
FROM(  
	--Logic ('03','06','09','12')
	SELECT 
		CASE
			WHEN "month" IN ('01','02','03') THEN CONCAT(fk_yearly ,'_', '03')
			WHEN "month" IN ('04','05','06') THEN CONCAT(fk_yearly ,'_', '06')
			WHEN "month" IN ('07','08','09') THEN CONCAT(fk_yearly ,'_', '09')
			WHEN "month" IN ('10','11','12') THEN CONCAT(fk_yearly ,'_', '12')
		END AS pk_quarter,
		ticker,
		MIN(startdate) AS startdate,
		MAX(enddate) AS enddate,
		MAX(high) AS high,
		MIN(low) AS low,
		SUM(volume) AS volume
	FROM "HISTORICAL"."vHISTORICAL_MONTHLY_MASTER"
	WHERE ticker IN
		( 
		SELECT 
			DISTINCT(ticker)	 
		FROM "FINANCIALS"."vFINANCIALS_QUARTERLY_MASTER_MATERIALIZED"
		WHERE RIGHT(pk,2) IN ('03','06','09','12')
		)
	GROUP BY pk_quarter, ticker
	
	UNION ALL 
	--Logic ('02','05','08','11')
	SELECT 
		CASE
			WHEN "month" = '12' THEN CONCAT(ticker,'_',CAST("year" AS int) + 1 ,'_', '02')
			WHEN "month" IN ('01','02') THEN CONCAT(fk_yearly ,'_', '02')
			WHEN "month" IN ('03','04','05') THEN CONCAT(fk_yearly ,'_', '05')
			WHEN "month" IN ('06','07','08') THEN CONCAT(fk_yearly ,'_', '08')
			WHEN "month" IN ('09','10','11') THEN CONCAT(fk_yearly ,'_', '11')
		END AS pk_quarter,
		ticker,
		MIN(startdate) AS startdate,
		MAX(enddate) AS enddate,
		MAX(high) AS high,
		MIN(low) AS low,
		SUM(volume) AS volume
	FROM "HISTORICAL"."vHISTORICAL_MONTHLY_MASTER"
	WHERE ticker IN
		( 
		SELECT 
			DISTINCT(ticker)	 
		FROM "FINANCIALS"."vFINANCIALS_QUARTERLY_MASTER_MATERIALIZED"
		WHERE RIGHT(pk,2) IN ('02','05','08','11')
		)
	GROUP BY pk_quarter, ticker
	
	UNION ALL

	--Logic ('04','07','10','01')
	SELECT 
		CASE
			WHEN "month" IN ('02','03','04') THEN CONCAT(fk_yearly ,'_', '04')
			WHEN "month" IN ('05','06','07') THEN CONCAT(fk_yearly ,'_', '07')
			WHEN "month" IN ('08','09','10') THEN CONCAT(fk_yearly ,'_', '10')
			WHEN "month" IN ('11','12') THEN CONCAT(ticker,'_',CAST("year" AS int) + 1 ,'_', '01')
			WHEN "month" IN ('01') THEN CONCAT(fk_yearly ,'_', '01')
		END AS pk_quarter,
		ticker,
		MIN(startdate) AS startdate,
		MAX(enddate) AS enddate,
		MAX(high) AS high,
		MIN(low) AS low,
		SUM(volume) AS volume
	-- select *
	FROM "HISTORICAL"."vHISTORICAL_MONTHLY_MASTER"
	WHERE ticker IN
		( 
		SELECT 
			DISTINCT(ticker)	 
		FROM "FINANCIALS"."vFINANCIALS_QUARTERLY_MASTER_MATERIALIZED"
		WHERE RIGHT(pk,2) IN ('04','07','10','01') 
		)
	GROUP BY pk_quarter, ticker 
	) t1

LEFT JOIN "HISTORICAL"."vHISTORICAL_MONTHLY_MASTER" t2
ON t1.startdate = t2.startdate AND t1.ticker = t2.ticker
LEFT JOIN "HISTORICAL"."vHISTORICAL_MONTHLY_MASTER" t3
ON t1.enddate = t3.enddate AND t1.ticker = t3.ticker
order by pk_quarter

WITH DATA;

ALTER TABLE "HISTORICAL"."vHISTORICAL_QUARTERLY_MASTER_MATERIALIZED"
    OWNER TO postgres;

--INDEX
--pk_quarter
CREATE UNIQUE INDEX pk_quarter
ON "HISTORICAL"."vHISTORICAL_QUARTERLY_MASTER_MATERIALIZED" USING btree
(pk_quarter ASC NULLS LAST)
INCLUDE(pk_quarter)

