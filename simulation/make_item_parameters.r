# simulation/make_item_parameters.r
# obtain item parameters to use in simulation

library(PROsetta)

root <- rprojroot::find_rstudio_root_file()

par_exists <-
  file.exists(file.path(root, "data/ipar_a.csv")) &
  file.exists(file.path(root, "data/ipar_d.csv"))

if (par_exists) {

  ipar_a <- read.csv(file.path(root, "data/ipar_a.csv"), row.names = 1)
  ipar_d <- read.csv(file.path(root, "data/ipar_d.csv"), row.names = 1)

} else {

  d <- getCompleteData(data_dep)

  set.seed(1)
  calib <- runCalibration(d, technical = list(NCYCLES = 1000))
  ipar  <- mirt::coef(calib, IRTpars = FALSE, simplify = TRUE)

  ipar   <- ipar$items
  ipar_a <- ipar[, c(1, 1)]
  ipar_d <- ipar[, 2:5]
  colnames(ipar_a) <- paste0("a", 1:2)

  cesd_items <- 29:48
  prom_items <-  1:28

  ipar_a[prom_items, 2] <- 0
  ipar_a[cesd_items, 1] <- 0

  write.csv(ipar_a, file.path(root, "data/ipar_a.csv"))
  write.csv(ipar_d, file.path(root, "data/ipar_d.csv"))

}

ipar_a <- as.matrix(ipar_a)
ipar_d <- as.matrix(ipar_d)

