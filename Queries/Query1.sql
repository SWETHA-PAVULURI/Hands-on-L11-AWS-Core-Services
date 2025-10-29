SELECT
    order_date,
    daily_sales,
    SUM(daily_sales) OVER (
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_sales
FROM (
    SELECT
        date_parse("Date", '%m-%d-%y') AS order_date,
        SUM("Amount") AS daily_sales
    FROM output_db.raw
    WHERE date_parse("Date", '%m-%d-%y') BETWEEN DATE '2022-01-01' AND DATE '2022-12-31'
    GROUP BY date_parse("Date", '%m-%d-%y')
) t
ORDER BY order_date
LIMIT 10;