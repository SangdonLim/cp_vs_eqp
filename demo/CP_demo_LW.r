# demo/CP_demo_LW.r
# likelihood values for 11 items in PedsQL instrument
# the test score ranges from 0-44

pedsql_items <- 18:28
L <- LWrecursion(itempool, pedsql_items, theta_grid)
