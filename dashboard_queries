SELECT 
    date_format(t.block_time, '%W') as day_of_week,
    extract(hour from t.block_time) as hour_of_day,
    
    -- THE BIG CHANGE: 
    -- Instead of 21000, we use t.gas_used
    -- Formula: Average( (Gas Price * Actual Gas Used) / 1e18 * ETH Price )
    AVG( (t.gas_price * t.gas_used / 1e18) * p.price ) as avg_actual_cost_usd,
    
    -- Helpful Bonus Metric:
    -- See how "heavy" the transactions are on average
    AVG(t.gas_used) as avg_gas_units_used

FROM ethereum.transactions t

LEFT JOIN prices.usd p 
    ON p.minute = date_trunc('minute', t.block_time)
    AND p.blockchain = 'ethereum'
    AND p.symbol = 'WETH'

WHERE t.block_time > now() - interval '30' day
AND extract(hour from t.block_time) BETWEEN 9 AND 17
AND extract(dow from t.block_time) BETWEEN 1 AND 5

-- OPTIONAL: Filter for "Complex" transactions only
-- Remove simple transfers so the average reflects contract interactions
AND t.gas_used > 21000 

GROUP BY 1, 2
ORDER BY 
    extract(dow from min(t.block_time)), -- Optimized sort
    hour_of_day
