# simulation/perform_EQP.r
# perform equipercentile equating

perform_EQP <- function(X) {

  dX          <- data_dep
  dX@response <- as.data.frame(X$data)
  person_id   <- seq(100001, 101000, 1)
  dX@response <- cbind(person_id, dX@response)
  colnames(dX@response) <- colnames(data_dep@response)

  # functions are from PROsetta package
  set.seed(1)
  eq_calib <- runCalibration(dX, technical = list(NCYCLES = 1000))
  eq_rsss  <- runRSSS(dX, eq_calib, min_score = 0)
  eq_conc  <- runEquateObserved(dX, smooth = "none", type_to = "theta", rsss = eq_rsss)
  eq_conc  <- eq_conc$concordance

  out <- list(
    eq_conc  = eq_conc,
    eq_calib = eq_calib
  )

  return(out)

}
