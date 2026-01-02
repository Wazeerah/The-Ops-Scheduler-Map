# The-Ops-Scheduler-Map
Cryto Ops teams have to make settlements or payments to our vendors on a regular schedule. Often, these are done blindly, without knowledge on when it's efficient for the institution to save money.

Gas fees are transaction fees paid to a network for processing a transaction. In TradFi, the fee is fixed, however in crypto, the fee changes every 12 seconds for the Ethereum network. When the network is busy, the price goes up. Think of it as gas needed to reach your destination.

This [map](https://dune.com/wazeerah/the-ops-scheduler) was thus created on Dune Analytics using Trino SQL and a Line Chart to visualize the best times of the day to make payments or settlements using the Ethereum network, with the intention to save operation fees by settling only when gas fees are low. 


The X-axis denotes the average gas fee, and the Y-axis denotes the hours of the day, the data is grouped by the days of the week. The color code is added on the chart.
