# demo/CP_demo_read.r
# read origin tables and create item objects

d2 <- read.csv(file.path(root, "data/table2.csv"))
d3 <- read.csv(file.path(root, "data/table3.csv"))
d  <- cbind(
  d2[order(d2[, 1]), ],
  d3[order(d3[, 1]), -1]
)

ipar <- d[, -c(1, 14)]
colnames(ipar)[9:12] <- paste0("d", 1:4)
ipar <- ipar[, c(1:2, 9:12)]

itempool <- generate.mirt_object(ipar, itemtype = "graded")
