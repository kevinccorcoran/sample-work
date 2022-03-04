-- Table: FINANCIALS.DATA_QUARTERLY_MASTER
-- DROP TABLE "FINANCIALS"."DATA_QUARTERLY_MASTER";

--CREATE TABLE
CREATE TABLE IF NOT EXISTS "FINANCIALS"."FINANCIALS_QUARTERLY_MASTER"
(
    sector text,
	industry text,
	pk text,
	fk text,
	ticker text COLLATE pg_catalog."default",
    period_end_date text COLLATE pg_catalog."default",
    revenue numeric,
    gross_profit numeric,
    rnd numeric,
    operating_income numeric,
    eps_diluted numeric,
    shares_diluted numeric,
    total_opex numeric,
    total_current_assets numeric,
    total_assets numeric,
    accounts_payable numeric,
    st_debt numeric,
    total_current_liabilities numeric,
    lt_debt numeric,
    total_liabilities numeric,
    total_equity numeric,
    total_liabilities_and_equity numeric,
    book_value numeric,
    tangible_book_value numeric,
    cfo_net_income numeric,
    cf_cfo numeric,
    cf_cfi numeric,
    cf_cff numeric,
    fcf numeric,
    roa numeric,
    roe numeric,
    roic numeric,
    roce numeric,
    rotce numeric,
    gross_margin numeric,
    operating_margin numeric,
    net_income_margin numeric,
    fcf_margin numeric,
    assets_to_equity numeric,
    equity_to_assets numeric,
    debt_to_equity numeric,
    debt_to_assets numeric,
    book_value_per_share numeric,
    tangible_book_per_share numeric,
    revenue_per_share numeric,
    operating_income_per_share numeric,
    fcf_per_share numeric,
    revenue_growth numeric,
    operating_income_growth numeric,
    net_income_growth numeric,
    eps_diluted_growth numeric,
    shares_diluted_growth numeric,
    total_assets_growth numeric,
    total_equity_growth numeric,
    fcf_growth numeric,
    market_cap numeric,
    period_end_price numeric,
    price_to_fcf numeric,
    price_to_earnings numeric,
    price_to_book numeric,
    price_to_tangible_book numeric,
    price_to_sales numeric,
    intangible_assets numeric,
    goodwill numeric,
    share_eop numeric,
    dividends numeric
)
TABLESPACE pg_default;
ALTER TABLE "FINANCIALS"."FINANCIALS_QUARTERLY_MASTER"
    OWNER to postgres;

-- CREATE INDEX
-- Index: period_end_date
CREATE INDEX period_end_date_dqm
    ON "FINANCIALS"."FINANCIALS_QUARTERLY_MASTER" USING btree
    (period_end_date COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: ticker
CREATE INDEX ticker_dqm
    ON "FINANCIALS"."FINANCIALS_QUARTERLY_MASTER" USING btree
    (ticker COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: pk
CREATE INDEX pk_dqm
    ON "FINANCIALS"."FINANCIALS_QUARTERLY_MASTER" USING btree
    (pk COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: fk
CREATE INDEX fk_dqm
    ON "FINANCIALS"."FINANCIALS_QUARTERLY_MASTER" USING btree
    (fk COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

--INSERT 
-- TRUNCATE TABLE "FINANCIALS"."DATA_QUARTERLY_MASTER"
-- SELECT * FROM "FINANCIALS"."DATA_QUARTERLY_MASTER"
INSERT INTO "FINANCIALS"."FINANCIALS_QUARTERLY_MASTER"
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
ORDER BY ticker, period_end_date
