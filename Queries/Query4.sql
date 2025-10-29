WITH ranked_products AS (
    SELECT
        "Category"                    AS category,
        "SKU"                         AS sku,
        SUM("Amount")                 AS total_revenue,
        RANK() OVER (
            PARTITION BY "Category"
            ORDER BY SUM("Amount") DESC
        ) AS rank_in_category
    FROM output_db.raw
    GROUP BY "Category", "SKU"
)
SELECT
    category,
    sku,
    total_revenue,
    rank_in_category
FROM ranked_products
WHERE rank_in_category <= 3
LIMIT 10;