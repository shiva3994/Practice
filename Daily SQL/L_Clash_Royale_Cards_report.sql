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

SELECT
		type,
		COUNT(*) as cardcount
FROM dbo.CRanalysis
GROUP BY type;

-- Find the rarity with the highest average hitpoints (use GROUP BY + ORDER BY + TOP 1).

SELECT TOP 1
		rarity,
		AVG(hitpoints) as avghitpoints
FROM dbo.CRanalysis
GROUP BY rarity
ORDER BY avghitpoints DESC;

-- Find all cards where hitpoints IS NULL (likely Spells) and list their name and type.

SELECT
		name,
		type
FROM dbo.CRanalysis
WHERE hitpoints IS NULL;

-- Count how many cards have a non-null maxEvolutionLevel (i.e., which cards can evolve).

SELECT 
		COUNT(*) as notnullcards
FROM dbo.CRanalysis
WHERE maxEvolutionLevel IS NOT NULL;

-- Write a query using CASE WHEN to bucket cards into 'Low Elixir' (<=3), 'Medium Elixir' (4-5), 'High Elixir' (>=6), then count cards in each bucket.

SELECT
	CASE
		WHEN elixirCost <= 3 THEN 'Low Elixir'
		WHEN elixirCost BETWEEN 4 AND 5 THEN 'Medium Elixir'
		WHEN elixirCost >= 6 THEN 'High Elixir'
	END AS elixir_bucket,
	COUNT(*) AS card_count

FROM dbo.CRanalysis
GROUP BY
    CASE
        WHEN elixirCost <= 3 THEN 'Low Elixir'
        WHEN elixirCost BETWEEN 4 AND 5 THEN 'Medium Elixir'
        WHEN elixirCost >= 6 THEN 'High Elixir'
    END;

-- Using a subquery or window function (RANK() / ROW_NUMBER()), find the top 3 cards by usage within each rarity.

SELECT
		name,
		rarity,
		usage,
		card_rank
FROM (
		SELECT
				name,
				rarity,
				usage,
				RANK() OVER (PARTITION BY rarity ORDER BY usage DESC) AS card_rank
		FROM dbo.CRanalysis
	) AS ranked
WHERE card_rank <= 3
ORDER BY rarity, card_rank;
