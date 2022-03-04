--1 CREATE MATERIALIZED VIEW
--CREATE MATERIALIZED VIEW "FINANCIALS"."vFINANCIALS_QUARTERLY_MASTER_MATERIALIZED"
--AS
SELECT * FROM(
	SELECT 
		sector,
		industry, 
		CONCAT(ticker, '_' ,LEFT(period_end_date, 4), '_', RIGHT(period_end_date, 2)) AS pk,
		CONCAT(ticker, '_' ,LEFT(period_end_date, 4)) AS fk, 
		ticker, period_end_date, revenue, gross_profit, rnd, operating_income, eps_diluted, shares_diluted, total_opex, total_current_assets, total_assets, accounts_payable, st_debt, total_current_liabilities, lt_debt, total_liabilities, total_equity, total_liabilities_and_equity, book_value, tangible_book_value, cfo_net_income, cf_cfo, cf_cfi, cf_cff, fcf, roa, roe, roic, roce, rotce, gross_margin, operating_margin, net_income_margin, fcf_margin, assets_to_equity, equity_to_assets, debt_to_equity, debt_to_assets, book_value_per_share, tangible_book_per_share, revenue_per_share, operating_income_per_share, fcf_per_share, revenue_growth, operating_income_growth, net_income_growth, eps_diluted_growth, shares_diluted_growth, total_assets_growth, total_equity_growth, fcf_growth, market_cap, period_end_price, price_to_fcf, price_to_earnings, price_to_book, price_to_tangible_book, price_to_sales, intangible_assets, goodwill, share_eop, dividends
	FROM(
		SELECT 
			'Healthcare' AS sector,
			'Biotechnology' AS industry,
			null AS pk,
			null AS fk,
			ticker, period_end_date, revenue, gross_profit, rnd, operating_income, eps_diluted, shares_diluted, total_opex, total_current_assets, total_assets, accounts_payable, st_debt, total_current_liabilities, lt_debt, total_liabilities, total_equity, total_liabilities_and_equity, book_value, tangible_book_value, cfo_net_income, cf_cfo, cf_cfi, cf_cff, fcf, roa, roe, roic, roce, rotce, gross_margin, operating_margin,net_income_margin, fcf_margin, assets_to_equity, equity_to_assets, debt_to_equity, debt_to_assets, book_value_per_share, tangible_book_per_share, revenue_per_share, operating_income_per_share, fcf_per_share,revenue_growth, operating_income_growth, net_income_growth, eps_diluted_growth, shares_diluted_growth, total_assets_growth, total_equity_growth, fcf_growth, market_cap, period_end_price, price_to_fcf, price_to_earnings, price_to_book, price_to_tangible_book, price_to_sales, intangible_assets, goodwill, share_eop, dividends	
		FROM "DATA"."HEALTHCARE_BIOTECHNOLOGY" 		
			UNION ALL
			SELECT 
				'Healthcare' AS sector,
				'Diagnostics & Research' AS industry,
				null AS pk,
				null AS fk,
				ticker, period_end_date, revenue, gross_profit, rnd, operating_income, eps_diluted, shares_diluted, total_opex, total_current_assets, total_assets, accounts_payable, st_debt, total_current_liabilities, lt_debt, total_liabilities, total_equity, total_liabilities_and_equity, book_value, tangible_book_value, cfo_net_income, cf_cfo, cf_cfi, cf_cff, fcf, roa, roe, roic, roce, rotce, gross_margin, operating_margin,net_income_margin, fcf_margin, assets_to_equity, equity_to_assets, debt_to_equity, debt_to_assets, book_value_per_share, tangible_book_per_share, revenue_per_share, operating_income_per_share, fcf_per_share,revenue_growth, operating_income_growth, net_income_growth, eps_diluted_growth, shares_diluted_growth, total_assets_growth, total_equity_growth, fcf_growth, market_cap, period_end_price, price_to_fcf, price_to_earnings, price_to_book, price_to_tangible_book, price_to_sales, intangible_assets, goodwill, share_eop, dividends
			FROM "DATA"."HEALTHCARE_DIAGNOSTICS_RESEARCH"		
		UNION ALL
			SELECT 
				'Basic Materials' AS sector,
				'Specialty Chemicals' AS industry,
				null AS pk,
				null AS fk,
				ticker, period_end_date, revenue, gross_profit, rnd, operating_income, eps_diluted, shares_diluted, total_opex, total_current_assets, total_assets, accounts_payable, st_debt, total_current_liabilities, lt_debt, total_liabilities, total_equity, total_liabilities_and_equity, book_value, tangible_book_value, cfo_net_income, cf_cfo, cf_cfi, cf_cff, fcf, roa, roe, roic, roce, rotce, gross_margin, operating_margin,net_income_margin, fcf_margin, assets_to_equity, equity_to_assets, debt_to_equity, debt_to_assets, book_value_per_share, tangible_book_per_share, revenue_per_share, operating_income_per_share, fcf_per_share,revenue_growth, operating_income_growth, net_income_growth, eps_diluted_growth, shares_diluted_growth, total_assets_growth, total_equity_growth, fcf_growth, market_cap, period_end_price, price_to_fcf, price_to_earnings, price_to_book, price_to_tangible_book, price_to_sales, intangible_assets, goodwill, share_eop, dividends
			FROM "DATA"."BASIC_MATERIAL_SPECIALTY_CHEMICALS"
		UNION ALL
			SELECT 
				'Technology' AS sector,
				'Software Application' AS industry,
				null AS pk,
				null AS fk,
				ticker, period_end_date, revenue, gross_profit, rnd, operating_income, eps_diluted, shares_diluted, total_opex, total_current_assets, total_assets, accounts_payable, st_debt, total_current_liabilities, lt_debt, total_liabilities, total_equity, total_liabilities_and_equity, book_value, tangible_book_value, cfo_net_income, cf_cfo, cf_cfi, cf_cff, fcf, roa, roe, roic, roce, rotce, gross_margin, operating_margin,net_income_margin, fcf_margin, assets_to_equity, equity_to_assets, debt_to_equity, debt_to_assets, book_value_per_share, tangible_book_per_share, revenue_per_share, operating_income_per_share, fcf_per_share,revenue_growth, operating_income_growth, net_income_growth, eps_diluted_growth, shares_diluted_growth, total_assets_growth, total_equity_growth, fcf_growth, market_cap, period_end_price, price_to_fcf, price_to_earnings, price_to_book, price_to_tangible_book, price_to_sales, intangible_assets, goodwill, share_eop, dividends
			FROM "DATA"."TECHNOLOGY_SOFTWARE_APPLICATION"
		UNION ALL
			SELECT 
				'Technology' AS sector,
				'Software Infrastructure' AS industry,
				null AS pk,
				null AS fk,
				ticker, period_end_date, revenue, gross_profit, rnd, operating_income, eps_diluted, shares_diluted, total_opex, total_current_assets, total_assets, accounts_payable, st_debt, total_current_liabilities, lt_debt, total_liabilities, total_equity, total_liabilities_and_equity, book_value, tangible_book_value, cfo_net_income, cf_cfo, cf_cfi, cf_cff, fcf, roa, roe, roic, roce, rotce, gross_margin, operating_margin,net_income_margin, fcf_margin, assets_to_equity, equity_to_assets, debt_to_equity, debt_to_assets, book_value_per_share, tangible_book_per_share, revenue_per_share, operating_income_per_share, fcf_per_share,revenue_growth, operating_income_growth, net_income_growth, eps_diluted_growth, shares_diluted_growth, total_assets_growth, total_equity_growth, fcf_growth, market_cap, period_end_price, price_to_fcf, price_to_earnings, price_to_book, price_to_tangible_book, price_to_sales, intangible_assets, goodwill, share_eop, dividends
			FROM "DATA"."TECHNOLOGY_SOFTWARE_INFRASTRUCTURE"
					) base_data
	WHERE period_end_date <> '0' 

	UNION ALL 

	SELECT
		*
	FROM(
		WITH new_records AS( 
			SELECT 
			/**
				CASE 
					WHEN null_sector IS NULL THEN sector
					ELSE t1.null_sector
				END sector,
				CASE 
					WHEN null_industry IS NULL THEN industry
					ELSE null_industry
				END industry, **/
				sector,	industry, pk, fk, ticker,
				null_period_end_date AS period_end_date,
				revenue, gross_profit, rnd, operating_income, eps_diluted, shares_diluted, total_opex, total_current_assets, total_assets, accounts_payable, st_debt, total_current_liabilities, lt_debt, total_liabilities, total_equity, total_liabilities_and_equity, book_value, tangible_book_value, cfo_net_income, cf_cfo, cf_cfi, cf_cff, fcf, roa, roe, roic, roce, rotce, gross_margin, operating_margin, net_income_margin, fcf_margin, assets_to_equity, equity_to_assets, debt_to_equity, debt_to_assets, book_value_per_share, tangible_book_per_share, revenue_per_share, operating_income_per_share, fcf_per_share, revenue_growth, operating_income_growth, net_income_growth, eps_diluted_growth, shares_diluted_growth, total_assets_growth, total_equity_growth, fcf_growth, market_cap, period_end_price, price_to_fcf, price_to_earnings, price_to_book, price_to_tangible_book, price_to_sales, intangible_assets, goodwill, share_eop, dividends
			FROM(
				SELECT 	
					null AS null_sector,
					null AS null_industry,
					CONCAT(t1.ticker, '_' ,LEFT(t1.period_end_date, 4), '_', RIGHT(t1.period_end_date, 2)) AS pk,
					CONCAT(t1.ticker, '_' ,LEFT(t1.period_end_date, 4)) AS fk,
					t1.ticker AS null_ticker,
					t1.period_end_date AS null_period_end_date, 
					t1.ticker,
					t2.sector,
					t2.industry,
					t2.period_end_date,
					t1.revenue, t1.gross_profit, t1.rnd, t1.operating_income, t1.eps_diluted, t1.shares_diluted, t1.total_opex, t1.total_current_assets, 
					t1.total_assets, t1.accounts_payable, t1.st_debt, t1.total_current_liabilities, t1.lt_debt, t1.total_liabilities, t1.total_equity, 
					t1.total_liabilities_and_equity, t1.book_value, t1.tangible_book_value, t1.cfo_net_income, t1.cf_cfo, t1.cf_cfi, t1.cf_cff, t1.fcf, t1.roa, 
					t1.roe, t1.roic, t1.roce, t1.rotce, t1.gross_margin, t1.operating_margin, t1.net_income_margin, t1.fcf_margin, t1.assets_to_equity, t1.equity_to_assets, 
					t1.debt_to_equity, t1.debt_to_assets, t1.book_value_per_share, t1.tangible_book_per_share, t1.revenue_per_share, t1.operating_income_per_share, 
					t1.fcf_per_share, t1.revenue_growth, t1.operating_income_growth, t1.net_income_growth, t1.eps_diluted_growth, t1.shares_diluted_growth, t1.total_assets_growth, 
					t1.total_equity_growth, t1.fcf_growth, t1.market_cap, t1.period_end_price, t1.price_to_fcf, t1.price_to_earnings, t1.price_to_book, t1.price_to_tangible_book, 
					t1.price_to_sales, t1.intangible_assets, t1.goodwill, t1.share_eop, t1.dividends
				FROM "DATA"."DATA_QUARTERLY_MASTER_STAGING" t1
				LEFT JOIN "FINANCIALS"."FINANCIALS_QUARTERLY_MASTER" t2
				ON t1.ticker = t2.ticker AND t1.period_end_date = t2.period_end_date
				WHERE t1.period_end_date <> '0' AND t2.period_end_date IS NULL
				ORDER BY ticker, t1.period_end_date desc
				) t1 
		)

		, distinct_records AS ( 
			SELECT
				DISTINCT 
				sector, 
				industry,
				ticker
			 FROM "FINANCIALS"."FINANCIALS_QUARTERLY_MASTER" ) 

		SELECT 
			distinct_records.sector,
			distinct_records.industry,
			pk,
			fk,
			new_records.ticker,
			period_end_date,
			revenue, gross_profit, rnd, operating_income, eps_diluted, shares_diluted, total_opex, total_current_assets, total_assets, accounts_payable, st_debt, total_current_liabilities, lt_debt, total_liabilities, total_equity, total_liabilities_and_equity, book_value, tangible_book_value, cfo_net_income, cf_cfo, cf_cfi, cf_cff, fcf, roa, roe, roic, roce, rotce, gross_margin, operating_margin, net_income_margin, fcf_margin, assets_to_equity, equity_to_assets, debt_to_equity, debt_to_assets, book_value_per_share, tangible_book_per_share, revenue_per_share, operating_income_per_share, fcf_per_share, revenue_growth, operating_income_growth, net_income_growth, eps_diluted_growth, shares_diluted_growth, total_assets_growth, total_equity_growth, fcf_growth, market_cap, period_end_price, price_to_fcf, price_to_earnings, price_to_book, price_to_tangible_book, price_to_sales, intangible_assets, goodwill, share_eop, dividends
		FROM new_records
		JOIN distinct_records
		ON new_records.ticker = distinct_records.ticker 
	) new_records

	ORDER BY ticker, period_end_date	
	) all_records

WITH DATA;

ALTER TABLE "FINANCIALS"."vFINANCIALS_QUARTERLY_MASTER_MATERIALIZED"
    OWNER TO postgres;

---------------------------------------------------
---------------------------------------------------
-- 2. CREATE INDEX
-- Index ticker
CREATE INDEX index
    ON "FINANCIALS"."vFINANCIALS_QUARTERLY_MASTER_MATERIALIZED" USING btree
    (sector ASC NULLS LAST, industry ASC NULLS LAST, fk ASC NULLS LAST, ticker ASC NULLS LAST, period_end_date ASC NULLS LAST)
    INCLUDE(sector, industry, fk, ticker, period_end_date)
-- Index pk	
CREATE UNIQUE INDEX pk
    ON "FINANCIALS"."vFINANCIALS_QUARTERLY_MASTER_MATERIALIZED" USING btree
    (pk ASC NULLS LAST)
    INCLUDE(pk)
-- Index period_end_date1		
CREATE INDEX period_end_date1
    ON "FINANCIALS"."vFINANCIALS_QUARTERLY_MASTER_MATERIALIZED" USING btree
    (period_end_date ASC NULLS LAST)
    INCLUDE(period_end_date)
;
	


