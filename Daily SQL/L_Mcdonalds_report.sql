SELECT *
FROM dbo.Mcdonalds;


-- 1. Write a query to `SELECT *` and check row counts per `table` category.

SELECT
    [table],
    COUNT(*) AS row_count
FROM dbo.Mcdonalds
GROUP BY [table];


-- 2. Write a query to filter only rows where `table = 'assets'`.

SELECT *
FROM dbo.Mcdonalds
WHERE [table] = 'assets';


-- 3. Find all subheadings where the 2024 value is greater than the 2023 value (YoY increase) — using `CASE WHEN` or a computed column.

SELECT
     subheading,
     [2023] AS Value_2023,
     [2024] AS Value_2024,
     CASE
        WHEN [2024] > [2023] THEN 'YoY Increase'
        ELSE 'No Increase'
     END AS YoY_status
FROM dbo.Mcdonalds
WHERE [2024] > [2023];


-- 4. Use `GROUP BY heading` to `SUM` the 2024 values within `revenue_breakdown`.

SELECT
        heading,
        SUM([2024]) AS sum_of_revenue2024 -- [2024] instead of 2024 — the square brackets tell SQL Server "this is a column name" not a numeric
FROM dbo.Mcdonalds
WHERE [table] = 'revenue_breakdown'
GROUP BY heading;


-- 5. Use a `CASE WHEN` to bucket line items into 'Revenue', 'Cost', or 'Other' based on `table`/`heading` values.




-- 6. Write a query using `ORDER BY` to rank subheadings by 2024 value, descending.



-- 7. Use a window function (`RANK()` or `ROW_NUMBER()`) to find the top 3 highest-value line items per `table`.


-- 8. Calculate YoY growth (2024 vs 2023) using a computed column: `(2024 - 2023) / NULLIF(2023,0) * 100`.


-- 9. Find all rows where any year's value is `NULL` and investigate why.


-- 10. Use a self-join or `LAG()` window function to compare each year's value to the prior year within the same `subheading`.


-- 11. Write a query to find the `subheading` with the maximum `net_income` contribution using `MAX()`.


-- 12. Use `HAVING` to find `heading` groups where total 2024 value exceeds a threshold (e.g., > 5000).


