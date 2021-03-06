/****** Script for SelectTopNRows command from SSMS  ******/

-- clustered index scan
SELECT count(order_id),[ship_via]
  FROM [fudgemart_orders]
  GROUP BY [ship_via]

  create nonclustered index ix_fudgemart_orders on [fudgemart_orders] (ship_via) ;

  -- yay non clustered index scan - using our new index.
SELECT count(order_id),[ship_via]
  FROM [fudgemart_orders]
  GROUP BY [ship_via]


  -- but this does not  :-(
SELECT count(order_id),customer_id
  FROM [fudgemart_orders]
  GROUP BY customer_id

 -- and it would require a second index, too.

  -- let's try a columnstore
create nonclustered columnstore index ix_fudgmart_orders_col 
	on fudgemart_orders (ship_via, customer_id)
	with (drop_existing = on)

 -- all columns
Create clustered columnstore index ix_fudgmart_orders_col_clus 
	on fudgemart_orders
	with (drop_existing = on)

-- uses our columnstore index
SELECT count(order_id),[ship_via]
  FROM [fudgemart_orders]
  GROUP BY [ship_via]

-- this works too!
SELECT count(order_id),[customer_id]
  FROM [fudgemart_orders]
  GROUP BY [customer_id]

