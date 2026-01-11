/* PROJECT: Brand Efficiency Audit
PHASE 1: SQL Data Engineering
GOAL: Aggregate raw logs into Brand-level KPIs using a CTE
*/

WITH BrandMetrics AS (
    SELECT 
        brand,
        SUM(impressions) AS total_imp,
        SUM(clicks) AS total_clicks,
        SUM(spend) AS total_spend,
        SUM(revenue) AS total_revenue
    FROM ad_tech_last_six_months
    GROUP BY brand
)
SELECT 
    brand,
    total_imp,      -- Now this will show up in your export
    total_clicks,   -- Now this will show up in your export
    total_spend,
    total_revenue,
    ROUND(total_revenue / NULLIF(total_spend, 0), 2) AS roas,
    ROUND((total_clicks / NULLIF(total_imp, 0)) * 100, 2) AS ctr_perc
FROM BrandMetrics
ORDER BY roas DESC;
