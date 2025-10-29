SELECT
    "Category"            AS category,
    CASE 
        WHEN "promotion-ids" IS NULL OR "promotion-ids" = '' THEN 'no_promo'
        ELSE 'promo_applied'
    END                   AS promo_flag,
    SUM("Amount")         AS total_amount,
    SUM("Qty")            AS total_qty,
    SUM("Amount") / NULLIF(SUM("Qty"), 0) AS avg_revenue_per_unit
FROM output_db.raw
GROUP BY
    "Category",
    CASE 
        WHEN "promotion-ids" IS NULL OR "promotion-ids" = '' THEN 'no_promo'
        ELSE 'promo_applied'
    END
ORDER BY avg_revenue_per_unit ASC
LIMIT 10;