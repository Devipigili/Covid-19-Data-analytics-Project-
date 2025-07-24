
-- Step 1: Create cleaned table
CREATE TABLE clean_covid_data (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date TEXT NOT NULL,
    country TEXT NOT NULL,
    confirmed INTEGER DEFAULT 0,
    deaths INTEGER DEFAULT 0,
    recovered INTEGER DEFAULT 0
);

-- Step 2: Import your cleaned CSV into this table via DB Browser for SQLite

-- Step 3: Top 5 countries with most confirmed cases
SELECT country, SUM(confirmed) AS total_confirmed
FROM clean_covid_data
GROUP BY country
ORDER BY total_confirmed DESC
LIMIT 5;

-- Step 4: Daily trend of confirmed cases globally
SELECT date, SUM(confirmed) AS daily_confirmed
FROM clean_covid_data
GROUP BY date
ORDER BY date;

-- Step 5: Running total of confirmed cases per country
SELECT 
    country,
    date,
    SUM(confirmed) OVER (PARTITION BY country ORDER BY date) AS running_total_confirmed
FROM clean_covid_data
ORDER BY country, date;

-- Step 6: Create a view for top 10 countries
CREATE VIEW top_countries_view AS
SELECT country, SUM(confirmed) AS total_confirmed
FROM clean_covid_data
GROUP BY country
ORDER BY total_confirmed DESC
LIMIT 10;
