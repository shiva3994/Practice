USE L_1_Airbnb_Listings;

-- 1. SELECT * FROM Listings LIMIT 10;

SELECT TOP 10 *
FROM Listings;

-- 2. SELECT COUNT(*) FROM Listings;

SELECT
	COUNT(*) AS total_count
FROM Listings;

-- 3. SELECT DISTINCT room_type FROM Listings;

SELECT
	DISTINCT(room_type) AS distinct_room_type
FROM Listings;

-- 4. SELECT name, accomodates FROM Listings ORDER BY accomodates DESC LIMIT 5;


-- 5. SELECT * FROM Listings WHERE bedrooms >= 2;


-- 6. SELECT AVG(accomodates) FROM Listings;


-- 7. SELECT COUNT(*) FROM Listings WHERE room_type = 'Entire home/apt';


-- 8. SELECT name FROM Listings WHERE bedrooms IS NULL;


-- 9. SELECT MIN(beds), MAX(beds) FROM Listings;


-- 10. SELECT property_type, COUNT(*) FROM Listings GROUP BY property_type;

