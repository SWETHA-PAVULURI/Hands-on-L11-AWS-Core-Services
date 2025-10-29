SELECT
    "ship-state" AS state,
    SUM("Amount") AS total_revenue
FROM output_db.raw
GROUP BY "ship-state"
ORDER BY total_revenue DESC
LIMIT 10;