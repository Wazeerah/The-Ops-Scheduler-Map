WITH eth_price AS (
  SELECT
    price
  FROM prices.usd
  WHERE
    symbol = 'WETH' AND blockchain = 'ethereum'
  ORDER BY
    minute DESC
  LIMIT 1
), l1_data AS (
  SELECT
    'Ethereum' AS network,
    AVG(gas_price / 1e9) AS avg_gas_price_gwei,
    AVG(gas_used) AS avg_gas_used,
    AVG((
      gas_price * gas_used
    ) / 1e18) AS avg_fee_native
  FROM ethereum.transactions
  WHERE
    block_time > CURRENT_TIMESTAMP - INTERVAL '1' day
), l2_data AS (
  SELECT
    'Arbitrum' AS network,
    AVG(effective_gas_price / 1e9) AS avg_gas_price_gwei,
    AVG(gas_used) AS avg_gas_used,
    AVG((
      effective_gas_price * gas_used
    ) / 1e18) AS avg_fee_native
  FROM arbitrum.transactions
  WHERE
    block_time > CURRENT_TIMESTAMP - INTERVAL '1' day
)
SELECT
  l1.network,
  l1.avg_gas_price_gwei, /* Should be ~10-50 */
  l1.avg_gas_used, /* Should be ~50k-100k */
  l1.avg_fee_native, /* Should be ~0.002 */
  l1.avg_fee_native * p.price AS cost_usd
FROM l1_data AS l1, eth_price AS p
UNION ALL
SELECT
  l2.network,
  l2.avg_gas_price_gwei, /* Should be TINY (< 0.1) */
  l2.avg_gas_used, /* Should be HUGE (~500k+) */
  l2.avg_fee_native, /* Should be TINY (~0.0001) */
  l2.avg_fee_native * p.price AS cost_usd
FROM l2_data AS l2, eth_price AS p
