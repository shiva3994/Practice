USE CRanalysis;

SELECT *
FROM dbo.CRanalysis;

-- Find all cards where elixirCost >= 6.

SELECT 
		name,
		elixirCost
FROM dbo.CRanalysis
WHERE elixirCost >= 6;

-- Find all cards where rarity = 'Legendary' AND type = 'Troop'.

SELECT 
		name,
		rarity,
		type
FROM dbo.CRanalysis
WHERE rarity = 'Legendary' AND type = 'Troop';

-- Get the average elixirCost grouped by rarity.

SELECT
		AVG(elixirCost) as avgelixer,
		rarity
FROM dbo.CRanalysis
GROUP BY rarity;

-- Get the count of cards per type.
-- Find the rarity with the highest average hitpoints (use GROUP BY + ORDER BY + TOP 1).


-- Find all cards where hitpoints IS NULL (likely Spells) and list their name and type.
-- Count how many cards have a non-null maxEvolutionLevel (i.e., which cards can evolve).


-- Write a query using CASE WHEN to bucket cards into 'Low Elixir' (<=3), 'Medium Elixir' (4-5), 'High Elixir' (>=6), then count cards in each bucket.

-- Using a subquery or window function (RANK() / ROW_NUMBER()), find the top 3 cards by usage within each rarity.