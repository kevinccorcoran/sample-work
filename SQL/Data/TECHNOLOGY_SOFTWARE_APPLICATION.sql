-- Table: DATA.TECHNOLOGY_SOFTWARE_INFRASTRUCTURE

-- DROP TABLE "DATA"."TECHNOLOGY_SOFTWARE_INFRASTRUCTURE"; ' ',

CREATE TABLE IF NOT EXISTS "DATA"."TECHNOLOGY_SOFTWARE_APPLICATION"
(
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

ALTER TABLE "DATA"."TECHNOLOGY_SOFTWARE_APPLICATION"
    OWNER to postgres;
	
--2. Indexes
-- Index: period_end_date
-- DROP INDEX "DATA".period_end_date;
CREATE INDEX period_end_date3
    ON "DATA"."TECHNOLOGY_SOFTWARE_APPLICATION" USING btree
    (period_end_date COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: ticker
-- DROP INDEX "DATA".ticker;
CREATE INDEX ticker3
    ON "DATA"."TECHNOLOGY_SOFTWARE_APPLICATION" USING btree
    (ticker COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
	
--3. COPY
COPY "DATA"."TECHNOLOGY_SOFTWARE_APPLICATION" 
FROM '/Users/kevin/Dropbox/Stonks/financials/technology_software_application.csv'
WITH (FORMAT CSV, HEADER)