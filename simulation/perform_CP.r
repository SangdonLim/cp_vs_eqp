# simulation/perform_CP.r
# perform calibrated projection

perform_CP <- function(X, theta_grid) {
  model = mirt.model("
    F1  =  1-28
    F2  = 29-48
    COV = F1*F2
    UBOUND = (GROUP, COV_21, .999)
  ")
  cp_calib       <- mirt(X$data, model, itemtype = "graded")
  cp_likelihoods <- LWrecursion(cp_calib, cesd_items, theta_grid)

  est_cor <- as.data.frame(coef(cp_calib)$GroupPars)
  est_cor <- est_cor[["COV_21"]]

  sigma          <- diag(nd)
  sigma[2, 1]    <- est_cor
  sigma[1, 2]    <- est_cor

  cp_eap  <- LtoEAP(cp_likelihoods, theta_grid, sigma)
  cp_out  <- EAPtoTABLE(cp_eap, FALSE, dimension = 1)

  return(cp_out)

}
