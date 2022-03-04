-- ===========================================
-- Author:		Kevin Corcoran
-- Description:	vQUARTERLY_MASTER_TTM_MATERIALIZED
-- Feb 26th 	Created
-- ===========================================

CREATE MATERIALIZED VIEW "ANALYTICS"."vQUARTERLY_MASTER_TTM_MATERIALIZED"
AS
-- to be quaterly master 2
WITH modulo AS(
	SELECT 
		rn,
		1 + ((rn - 1) % 4) AS modulo,	
		pk,
		fk,
		ticker, 
		period_end_date,
		sector, 
		industry
	FROM(
		SELECT 
			ROW_NUMBER () OVER (PARTITION BY ticker ORDER BY period_end_date desc) AS rn,
			pk,
			fk,
			ticker, 
			period_end_date,
			sector, 
			industry
		FROM "ANALYTICS"."vQUARTERLY_MASTER"
	) modulo
)
	
, summations AS(
		SELECT 
			ROW_NUMBER () OVER (PARTITION BY ticker ORDER BY period_end_date desc) AS rn,
			sector, 
			industry, 
			pk, 
			fk, 
			ticker, 
			period_end_date, 
			SUM(revenue) OVER (PARTITION BY ticker ORDER BY period_end_date DESC ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS revenue_ttm, 
			SUM(gross_profit) OVER (PARTITION BY ticker ORDER BY period_end_date DESC ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS gross_profit_ttm,
			SUM(rnd) OVER (PARTITION BY ticker ORDER BY period_end_date DESC ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS rnd_ttm,
			SUM(operating_income) OVER (PARTITION BY ticker ORDER BY period_end_date DESC ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS operating_income_ttm,
			SUM(eps_diluted) OVER (PARTITION BY ticker ORDER BY period_end_date DESC ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS eps_diluted_ttm,			
			SUM(total_opex) OVER (PARTITION BY ticker ORDER BY period_end_date DESC ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS total_opex_ttm,
			SUM(st_debt) OVER (PARTITION BY ticker ORDER BY period_end_date DESC ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS st_debt_ttm,
			SUM(total_equity) OVER (PARTITION BY ticker ORDER BY period_end_date DESC ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS total_equity_ttm,
			SUM(cfo_net_income) OVER (PARTITION BY ticker ORDER BY period_end_date DESC ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS cfo_net_income_ttm,
			SUM(cf_cfo) OVER (PARTITION BY ticker ORDER BY period_end_date DESC ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS cf_cfo_ttm,
			SUM(cf_cfi) OVER (PARTITION BY ticker ORDER BY period_end_date DESC ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS cf_cfi_ttm,
			SUM(cf_cff) OVER (PARTITION BY ticker ORDER BY period_end_date DESC ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS cf_cff_ttm,
			SUM(fcf) OVER (PARTITION BY ticker ORDER BY period_end_date DESC ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS fcf_ttm,
			SUM(operating_income_per_share) OVER (PARTITION BY ticker ORDER BY period_end_date DESC ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS operating_income_per_share_ttm,
			SUM(fcf_per_share) OVER (PARTITION BY ticker ORDER BY period_end_date DESC ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS fcf_per_share_ttm, 			
			SUM(volume) OVER (PARTITION BY ticker ORDER BY period_end_date DESC ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS volume_ttm,
			SUM(dividends) OVER (PARTITION BY ticker ORDER BY period_end_date DESC ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS dividends_ttm,
			SUM(revenue_per_share) OVER (PARTITION BY ticker ORDER BY period_end_date DESC ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS revenue_per_share_ttm			
		FROM "ANALYTICS"."vQUARTERLY_MASTER"
		--where ticker = 'A'
		ORDER BY ticker, period_end_date desc
	)

, not_summations AS(
		SELECT 
			ROW_NUMBER () OVER (PARTITION BY ticker ORDER BY period_end_date desc) AS rn,
			pk, 
			shares_diluted,
			total_current_assets,
			total_assets,
			accounts_payable,
			total_current_liabilities,
			lt_debt,
			total_liabilities,
			total_liabilities_and_equity,
			book_value,
			tangible_book_value,
			assets_to_equity,
			equity_to_assets,
			debt_to_equity,
			debt_to_assets,
			book_value_per_share,
			tangible_book_per_share,
			market_cap,
			period_end_price,
			price_to_fcf,
			price_to_earnings,
			price_to_book,
			price_to_tangible_book,
			price_to_sales,
			intangible_assets,
			goodwill,
			share_eop,
			total_equity,
			st_debt,
			roe,
			roa,
			roic,
			roce,
			rotce
		FROM "ANALYTICS"."vQUARTERLY_MASTER"
		ORDER BY ticker, period_end_date desc			
)

, averages AS(
select * from(
		SELECT 
			ROW_NUMBER () OVER (PARTITION BY ticker ORDER BY period_end_date desc) AS rn,
			pk, 
			round(AVG(gross_margin) OVER (PARTITION BY ticker ORDER BY period_end_date DESC ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING), 2) AS gross_margin_ttm,
			round(AVG(operating_margin) OVER (PARTITION BY ticker ORDER BY period_end_date DESC ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING), 2) AS operating_margin_ttm,
			round(AVG(revenue_growth) OVER (PARTITION BY ticker ORDER BY period_end_date DESC ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING), 2) AS revenue_growth_ttm,
			round(AVG(net_income_margin) OVER (PARTITION BY ticker ORDER BY period_end_date DESC ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING), 2) AS net_income_margin_ttm,			
			round(AVG(fcf_margin) OVER (PARTITION BY ticker ORDER BY period_end_date DESC ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING), 2) AS fcf_margin_ttm	
		FROM "ANALYTICS"."vQUARTERLY_MASTER"
		ORDER BY ticker, period_end_date desc	
			) q 
)

, yahoo_finance AS(
	SELECT 
		1 + ((rn - 1) % 4) AS modulo,
		t1.pk_quarter,
		t1.ticker,
		t1.startdate,
		t1.enddate,
		t2."open",
		t1.high,
		t1.low,
		t3."close"
	FROM(
	SELECT 
		ROW_NUMBER () OVER (PARTITION BY ticker ORDER BY period_end_date desc) AS rn,
		max(pk_quarter) OVER (PARTITION BY ticker ORDER BY period_end_date DESC ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS pk_quarter,
		ticker, 
		min(startdate) OVER (PARTITION BY ticker ORDER BY period_end_date DESC ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS startdate,
		max(enddate) OVER (PARTITION BY ticker ORDER BY period_end_date DESC ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS enddate,	
		min(low) OVER (PARTITION BY ticker ORDER BY period_end_date DESC ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS low,
		max(high) OVER (PARTITION BY ticker ORDER BY period_end_date DESC ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS high
		FROM "ANALYTICS"."vQUARTERLY_MASTER"  ) t1 
	LEFT JOIN "ANALYTICS"."vQUARTERLY_MASTER" t2
	ON t1.startdate = t2.startdate AND t1.ticker = t2.ticker
	LEFT JOIN "ANALYTICS"."vQUARTERLY_MASTER" t3
	ON t1.enddate = t3.enddate AND t1.ticker = t3.ticker	
	WHERE 1 + ((rn - 1) % 4) = 1
	--and t1.ticker = 'ADBE'
	order by pk_quarter desc		
)


SELECT
	--modulo
	t1.modulo, t1.pk, t1.fk, t1. ticker, t1.period_end_date, t1.sector, t1.industry,
	--yahoo_finance
	--pk_quarter, 
	startdate, enddate,	"open", high, low, "close", volume_ttm, --(summation)
	--summations
	revenue_ttm, gross_profit_ttm, rnd_ttm, operating_income_ttm, eps_diluted_ttm, 
	total_opex_ttm, cfo_net_income_ttm, cf_cfo_ttm, cf_cfi_ttm, cf_cff_ttm, fcf_ttm, 
	round(operating_income_per_share_ttm, 2) AS operating_income_per_share_ttm, 
	round(fcf_per_share_ttm, 2) AS fcf_per_share_ttm,
	round(dividends_ttm, 2) AS dividends_ttm,
	round(revenue_per_share_ttm, 2) AS revenue_per_share_ttm,	
	--not_summations
	shares_diluted,	
	total_current_assets, 
	total_assets, 
	accounts_payable, 
	total_current_liabilities,
	lt_debt, total_liabilities,	
	total_liabilities_and_equity, 
	book_value, tangible_book_value,
	round(assets_to_equity, 2) AS assets_to_equity,
	round(equity_to_assets, 2) AS equity_to_assets,
	round(debt_to_equity, 2) AS debt_to_equity,
	round(debt_to_assets, 2) AS debt_to_assets,
	round(book_value_per_share, 2) AS book_value_per_share,
	round(tangible_book_per_share, 2) AS tangible_book_per_share,
	market_cap, 
	period_end_price, 
	round(price_to_fcf, 2) AS price_to_fcf,
	round(price_to_earnings, 2) AS price_to_earnings,
	round(price_to_book, 2) AS price_to_book,
	round(price_to_tangible_book, 2) AS price_to_tangible_book,
	round(price_to_sales, 2) AS price_to_sales,
	intangible_assets, goodwill,
	share_eop, 
	total_equity, 
	st_debt, 	
	round(roe, 2) AS roe,
	round(roa, 2) AS roa,
	round(roic, 2) AS roic,
	round(roce, 2) AS roce,
	round(rotce, 2) AS rotce,
	--averages
	gross_margin_ttm, operating_margin_ttm, revenue_growth_ttm, net_income_margin_ttm, fcf_margin_ttm	
	
FROM modulo t1
JOIN summations t2 
ON t1.pk = t2.pk
JOIN not_summations t3
ON t1.pk = t3.pk
JOIN averages t4 
ON t1.pk = t4.pk
JOIN yahoo_finance t5
ON t1.pk = t5.pk_quarter

--WHERE  modulo = 1
	--AND t1.ticker IN ('ADBE') 
--where t1.ticker = 'A'
--WHERE t1.pk IN ('ADSK_2021_01','ADSK_2020_01','NET_2020_12')
	--WHERE ticker IN ('NET', 'ADSK', 'ABDE')
ORDER BY t1.ticker, t1.period_end_date desc	

WITH DATA;

ALTER TABLE "ANALYTICS"."vQUARTERLY_MASTER_TTM_MATERIALIZED"
    OWNER TO postgres;

--CREATE INDEX
--pk
CREATE UNIQUE INDEX pk
    ON "ANALYTICS"."vQUARTERLY_MASTER_TTM_MATERIALIZED" USING btree
    (pk ASC NULLS LAST)
    INCLUDE(pk)