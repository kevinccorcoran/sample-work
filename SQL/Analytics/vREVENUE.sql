-- ===========================================
-- Author:		Kevin Corcoran
-- Description:	Logic for vREVENUE
-- QA
-- Mar. 1st - creation
-- ===========================================

--CREATE OR REPLACE VIEW "ANALYTICS"."vREVENUE"
--AS
--regression_slope is the core-base query used to calculate slope
WITH regression_slope AS(
	SELECT
		ROW_NUMBER() OVER ( PARTITION BY ticker ORDER BY past_ped ) AS rownum,
		*
	FROM(
		--Side-by-side comparison between current and past prices
		SELECT
		--round(ABS(concat(LEFT(current_ped, 7) , '-01')::date - concat(LEFT(past_ped, 7), '-01')::date)/(365.25)) AS diff_year,
			*
		FROM(
			--current prices
			WITH current_prices AS(
				SELECT
					--pk,
					ticker, 
					sector,
					industry,
					period_end_date AS current_ped,
					period_end_price AS current_pep,
					revenue_ttm
				FROM(
					SELECT 
						ROW_NUMBER () OVER (PARTITION BY ticker ORDER BY period_end_date DESC) AS rn,
					--	pk,
						ticker, 
						sector,
						industry,
						period_end_date,
						period_end_price,
						revenue_ttm
					FROM "ANALYTICS"."vQUARTERLY_MASTER_TTM_MATERIALIZED"
					ORDER BY ticker, period_end_date desc ) current_prices		
					WHERE rn = 1  
			)	

			-- Enterprise sizes
			, enterprise_sizes AS(
				SELECT 
					pk,
					ticker, 
					period_end_date AS past_ped, 
					period_end_price AS past_pep,
					revenue_ttm
				FROM "ANALYTICS"."vQUARTERLY_MASTER_TTM_MATERIALIZED" 
				)	

			--Revenue Rate Of Change in % for current and past periode end dates
			, revenue_roc AS(
					SELECT
						ticker,
						pk,
						period_end_date,
						round((diff_to_prev/(revenue_ttm - diff_to_prev)), 2)*100 AS revenue_roc
					FROM(
						SELECT 
							ticker,
							pk,
							period_end_date, 
							CAST(revenue_ttm AS numeric),
							CAST(revenue_ttm - lag(revenue_ttm) over (partition by ticker order by pk) AS numeric) as diff_to_prev
						FROM "ANALYTICS"."vQUARTERLY_MASTER_TTM_MATERIALIZED"
						WHERE revenue_ttm <> 0 
						ORDER by  ticker, period_end_date desc ) t1
					)

		SELECT 
			t1.ticker,
			t2.pk,
			t1.sector,
			t1.industry,
			t1.current_ped,
			t1.current_pep,
			t2.past_ped,
			t2.past_pep,
			t2.revenue_ttm,
			t3.revenue_roc
		FROM current_prices t1 	
		JOIN enterprise_sizes t2
			ON t1.ticker = t2.ticker
		JOIN revenue_roc t3
			ON t2.pk = t3.pk
			--ON t2.ticker = t3.ticker AND t2.current_ped = t3.past_ped
		ORDER BY ticker, past_ped desc	
	) my_view
	WHERE past_ped <> '0' 
	OR past_pep <> '0' ) base_view 
	--ORDER BY ticker, past_ped desc--end regression_slope
) 
--This is where the slope is calculated using regression_slope
SELECT 
	DISTINCT 
	t1.ticker, 
	t2.pk, 
	t2.sector, 
	t2.industry, 
	t1.current_ped, 
	t2.current_pep,
	t1.past_ped, 
	t2.past_pep, 
	revenu_roc_slope, 
	revenu_roc_y_intercept, revenu_roc_r_squared, 
	t2.revenue_ttm, 
	t2.revenue_roc
FROM(
	SELECT
		max,
		ticker,	
		current_ped, 
		max(past_ped) AS past_ped, 
		round(regr_slope(revenue_roc, rownum)::numeric, 2) AS revenu_roc_slope,
		round(regr_intercept(revenue_roc, rownum)::numeric, 2) AS revenu_roc_y_intercept,
		round(regr_r2(revenue_roc, rownum)::numeric, 3) AS revenu_roc_r_squared
	FROM regression_slope
	INNER JOIN generate_series(4, 24) AS max -- the range 4 to 24 can be adjusted to the need
		ON rownum < max
	GROUP BY max, ticker, current_ped
	ORDER BY max asc, ticker asc ) t1 	
JOIN regression_slope t2
ON t1.ticker = t2.ticker  AND t1.past_ped = t2.past_ped 
--ON t1.pk = t2.pk 
ORDER BY t1.ticker, past_ped desc
;
--ALTER TABLE "ANALYTICS"."vREVENUE"
 --   OWNER TO postgres;
 
/** Testing
https://www.socscistatistics.com/tests/regression/default.aspx
SELECT
	ROW_NUMBER() OVER ( PARTITION BY ticker ORDER BY past_ped ) AS rownum,
	*
FROM "ANALYTICS"."vREVENUE"
where ticker = 'AKZOF'
 **/