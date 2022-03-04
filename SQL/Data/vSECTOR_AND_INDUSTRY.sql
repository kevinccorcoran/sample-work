--CREATE OR REPLACE VIEW "DATA"."vSECTOR_AND_INDUSTRY"
 --AS
SELECT * FROM(
		SELECT 
			'Healthcare' AS sector,
			'Biotechnology' AS industry,
			ticker, period_end_date, revenue, gross_profit, rnd, operating_income, eps_diluted, shares_diluted, total_opex, total_current_assets, total_assets, accounts_payable, st_debt, total_current_liabilities, lt_debt, total_liabilities, total_equity, total_liabilities_and_equity, book_value, tangible_book_value, cfo_net_income, cf_cfo, cf_cfi, cf_cff, fcf, roa, roe, roic, roce, rotce, gross_margin, operating_margin,net_income_margin, fcf_margin, assets_to_equity, equity_to_assets, debt_to_equity, debt_to_assets, book_value_per_share, tangible_book_per_share, revenue_per_share, operating_income_per_share, fcf_per_share,revenue_growth, operating_income_growth, net_income_growth, eps_diluted_growth, shares_diluted_growth, total_assets_growth, total_equity_growth, fcf_growth, market_cap, period_end_price, price_to_fcf, price_to_earnings, price_to_book, price_to_tangible_book, price_to_sales, intangible_assets, goodwill, share_eop, dividends	
		FROM "DATA"."HEALTHCARE_BIOTECHNOLOGY" 	
		UNION ALL
		SELECT 
			'Healthcare' AS sector,
			'Diagnostics & Research' AS industry,
			ticker, period_end_date, revenue, gross_profit, rnd, operating_income, eps_diluted, shares_diluted, total_opex, total_current_assets, total_assets, accounts_payable, st_debt, total_current_liabilities, lt_debt, total_liabilities, total_equity, total_liabilities_and_equity, book_value, tangible_book_value, cfo_net_income, cf_cfo, cf_cfi, cf_cff, fcf, roa, roe, roic, roce, rotce, gross_margin, operating_margin,net_income_margin, fcf_margin, assets_to_equity, equity_to_assets, debt_to_equity, debt_to_assets, book_value_per_share, tangible_book_per_share, revenue_per_share, operating_income_per_share, fcf_per_share,revenue_growth, operating_income_growth, net_income_growth, eps_diluted_growth, shares_diluted_growth, total_assets_growth, total_equity_growth, fcf_growth, market_cap, period_end_price, price_to_fcf, price_to_earnings, price_to_book, price_to_tangible_book, price_to_sales, intangible_assets, goodwill, share_eop, dividends
		FROM "DATA"."HEALTHCARE_DIAGNOSTICS_RESEARCH"		
	UNION ALL
		SELECT 
			'Basic Materials' AS sector,
			'Specialty Chemicals' AS industry,
			ticker, period_end_date, revenue, gross_profit, rnd, operating_income, eps_diluted, shares_diluted, total_opex, total_current_assets, total_assets, accounts_payable, st_debt, total_current_liabilities, lt_debt, total_liabilities, total_equity, total_liabilities_and_equity, book_value, tangible_book_value, cfo_net_income, cf_cfo, cf_cfi, cf_cff, fcf, roa, roe, roic, roce, rotce, gross_margin, operating_margin,net_income_margin, fcf_margin, assets_to_equity, equity_to_assets, debt_to_equity, debt_to_assets, book_value_per_share, tangible_book_per_share, revenue_per_share, operating_income_per_share, fcf_per_share,revenue_growth, operating_income_growth, net_income_growth, eps_diluted_growth, shares_diluted_growth, total_assets_growth, total_equity_growth, fcf_growth, market_cap, period_end_price, price_to_fcf, price_to_earnings, price_to_book, price_to_tangible_book, price_to_sales, intangible_assets, goodwill, share_eop, dividends
		FROM "DATA"."BASIC_MATERIAL_SPECIALTY_CHEMICALS"
	UNION ALL
		SELECT 
			'Technology' AS sector,
			'Software Application' AS industry,
			ticker, period_end_date, revenue, gross_profit, rnd, operating_income, eps_diluted, shares_diluted, total_opex, total_current_assets, total_assets, accounts_payable, st_debt, total_current_liabilities, lt_debt, total_liabilities, total_equity, total_liabilities_and_equity, book_value, tangible_book_value, cfo_net_income, cf_cfo, cf_cfi, cf_cff, fcf, roa, roe, roic, roce, rotce, gross_margin, operating_margin,net_income_margin, fcf_margin, assets_to_equity, equity_to_assets, debt_to_equity, debt_to_assets, book_value_per_share, tangible_book_per_share, revenue_per_share, operating_income_per_share, fcf_per_share,revenue_growth, operating_income_growth, net_income_growth, eps_diluted_growth, shares_diluted_growth, total_assets_growth, total_equity_growth, fcf_growth, market_cap, period_end_price, price_to_fcf, price_to_earnings, price_to_book, price_to_tangible_book, price_to_sales, intangible_assets, goodwill, share_eop, dividends
		FROM "DATA"."TECHNOLOGY_SOFTWARE_APPLICATION"
	UNION ALL
		SELECT 
			'Technology' AS sector,
			'Software Infrastructure' AS industry,
			ticker, period_end_date, revenue, gross_profit, rnd, operating_income, eps_diluted, shares_diluted, total_opex, total_current_assets, total_assets, accounts_payable, st_debt, total_current_liabilities, lt_debt, total_liabilities, total_equity, total_liabilities_and_equity, book_value, tangible_book_value, cfo_net_income, cf_cfo, cf_cfi, cf_cff, fcf, roa, roe, roic, roce, rotce, gross_margin, operating_margin,net_income_margin, fcf_margin, assets_to_equity, equity_to_assets, debt_to_equity, debt_to_assets, book_value_per_share, tangible_book_per_share, revenue_per_share, operating_income_per_share, fcf_per_share,revenue_growth, operating_income_growth, net_income_growth, eps_diluted_growth, shares_diluted_growth, total_assets_growth, total_equity_growth, fcf_growth, market_cap, period_end_price, price_to_fcf, price_to_earnings, price_to_book, price_to_tangible_book, price_to_sales, intangible_assets, goodwill, share_eop, dividends
		FROM "DATA"."TECHNOLOGY_SOFTWARE_INFRASTRUCTURE"
				) t1
ORDER BY sector, industry;

--ALTER TABLE "DATA"."vSECTOR_AND_INDUSTRY"
  --  OWNER TO postgres;