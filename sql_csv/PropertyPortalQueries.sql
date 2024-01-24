Here is a list of different queries that a real estate agent supervisor may want to run. 

/* Query to identify which agents with the most houses sold in a list from top to bottom. */


SELECT 
    A.agent_id,
    A.first_name,
    A.last_name,
    COUNT(T.property_id) AS properties_sold
FROM 
    Agent A
LEFT JOIN 
    Transaction T ON A.agent_id = T.agent_id
LEFT JOIN 
    Property_Listing PL ON T.property_id = PL.property_id AND PL.property_status = 'sold'
GROUP BY 
    A.agent_id, A.first_name, A.last_name
ORDER BY 
    properties_sold DESC;



/* Query to that lists all of the unsold properties from longest date on the market to most recent (in descending order): */

SELECT 
    property_id,
    property_type,
    address,
    city,
    state,
    zip_code,
    price,
    bedrooms,
    bathrooms,
    listing_date,
    property_status
FROM 
    Property_Listing
WHERE 
    property_status <> 'sold' -- Adjust based on your actual data
ORDER BY 
    listing_date ASC; -- Sorts from oldest to newest
