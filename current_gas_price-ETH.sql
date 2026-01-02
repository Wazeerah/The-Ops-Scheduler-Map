WITH current_eth_price AS (
    -- Get the most recent price of ETH from the pricing table
    SELECT price 
    FROM prices.usd 
    WHERE symbol = 'WETH' 
    AND blockchain = 'ethereum' 
    ORDER BY minute DESC 
    LIMIT 1
),

latest_gas AS (
    -- Get the most recent gas price from the transactions table
    SELECT gas_price 
    FROM ethereum.transactions 
    ORDER BY block_time DESC 
    LIMIT 1
)
