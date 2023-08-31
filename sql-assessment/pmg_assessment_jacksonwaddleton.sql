-- 1: Write a query to get the sum of impressions by day. 
SELECT date, sum(impressions) 
FROM marketing_data
GROUP BY date
ORDER BY date asc;

-- 2. Write a query to get the top three revenue-generating states in order of best to worst. How much revenue did the third best state generate?
SELECT state, sum(revenue)
FROM website_revenue
GROUP BY state
ORDER BY sum(revenue) desc
LIMIT 1
OFFSET 2;

#The third-highest revenue-generating state is Ohio, which generated $37,577 in revenue. 

-- 3. Write a query that shows total cost, impressions, clicks, and revenue of each campaign. Make sure to include the campaign name in the output.
SELECT id, name, sum(cost), sum(impressions), sum(clicks), sum(revenue) 
FROM campaign_info 
JOIN marketing_data ON campaign_info.id = marketing_data.campaign_id 
JOIN website_revenue ON campaign_info.id = website_revenue.campaign_id 
GROUP BY id;

-- 4. Write a query to get the number of conversions of Campaign5 by state. Which state generated the most conversions for this campaign?
SELECT name, state, COUNT(conversions) as totalConversions
FROM campaign_info
JOIN website_revenue ON campaign_info.id = website_revenue.campaign_id
JOIN marketing_data ON campaign_info.id = marketing_data.campaign_id
WHERE name = 'Campaign5'
GROUP BY state
ORDER BY totalConversions DESC
LIMIT 1;

-- 5. In your opinion, which campaign was the most efficient, and why?
SELECT name, 
sum(cost), 
sum(impressions) / sum(cost) as impressionRatio, 
sum(clicks) / sum(cost) as clickRatio,
sum(conversions) / sum(cost) as conversionRatio,
sum(revenue) / sum(cost) as profitRatio
FROM campaign_info
JOIN website_revenue ON campaign_info.id = website_revenue.campaign_id
JOIN marketing_data ON campaign_info.id = marketing_data.campaign_id
GROUP BY name
ORDER BY name;

-- In my opinion, Campaign 4 was the most efficient given its low cost and high impression, click, conversion, and profit ratios (relative to costs). Campaign 4 delivered excellent results at a low cost. 

-- 6. Write a query that showcases the best day of the week (e.g., Sunday, Monday, Tuesday, etc.) to run ads.
SELECT
CASE 
	WHEN marketing_data.date = '2023-07-24' OR marketing_data.date = '2023-08-14' THEN 'Monday'
	WHEN marketing_data.date = '2023-07-26' OR marketing_data.date = '2023-08-02' THEN 'Wednesday'
	WHEN marketing_data.date = '2023-07-27' OR marketing_data.date = '2023-08-03' OR marketing_data.date = '2023-08-10' OR marketing_data.date = '2023-08-17' THEN 'Thursday'
	WHEN marketing_data.date = '2023-07-28' OR marketing_data.date = '2023-08-04' OR marketing_data.date = '2023-08-11' THEN 'Friday'
	WHEN marketing_data.date = '2023-07-29' OR marketing_data.date = '2023-08-05' OR marketing_data.date = '2023-08-12' OR marketing_data.date = '2023-08-19' THEN 'Saturday'
	WHEN marketing_data.date = '2023-07-30' OR marketing_data.date = '2023-08-13' THEN 'Sunday'
ELSE 'no'
END as dayOfWeek,
sum(cost), 
sum(impressions) / sum(cost) as impressionRatio, 
sum(clicks) / sum(cost) as clickRatio,
sum(conversions) / sum(cost) as conversionRatio,
sum(revenue) / sum(cost) as profitRatio
FROM marketing_data 
JOIN campaign_info on marketing_data.campaign_id = campaign_info.id
JOIN website_revenue on marketing_data.campaign_id = website_revenue.campaign_id
GROUP BY dayOfWeek
ORDER BY impressionRatio desc;

-- The best day of the week to run ads can be determined in multiple ways. In my opinion, Friday is the best day of the weel due to its association with high impression, conversion, and profit ratios. 