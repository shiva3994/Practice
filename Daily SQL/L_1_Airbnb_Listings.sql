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

SELECT TOP 5
	name,
	accomodates
FROM Listings
ORDER BY accomodates DESC;

-- 5. SELECT * FROM Listings WHERE bedrooms >= 2;

SELECT*
FROM Listings
WHERE bedrooms >= 2;

-- 6. SELECT AVG(accomodates) FROM Listings;

SELECT
	AVG(accomodates) AS avg_accomodation
FROM Listings;

-- 7. SELECT COUNT(*) FROM Listings WHERE room_type = 'Entire home/apt';

SELECT
	COUNT(*) AS count_of_apt
FROM Listings L
WHERE room_type = 'Entire home/apt';

-- 8. SELECT name FROM Listings WHERE bedrooms IS NULL;

SELECT
	name
FROM Listings
WHERE bedrooms IS NULL;

-- 9. SELECT MIN(beds), MAX(beds) FROM Listings;

SELECT
	MIN(beds) AS minimum_beds,
	MAX(beds) as maximum_beds
FROM Listings;

-- 10. SELECT property_type, COUNT(*) FROM Listings GROUP BY property_type;

SELECT
	property_type,
	COUNT(*) AS count_type
FROM Listings
GROUP BY property_type;