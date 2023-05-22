# Example code for running calibrated projection -------------------------------

source("module/module_grid.r")
source("module/module_computeResponseProbability.r")
source("module/module_LWrecursion.r")
source("module/module_LtoEAP.r")
source("module/module_EAPtoTABLE.r")

library(PROsetta)
library(mirt)
library(mvnfast)

d <- data_dep@response[, -1]
m <- mirt.model("
  F1 =  1-28  # Factor 1: PROMIS
  F2 = 29-48  # Factor 2: CESD
  COV = F1*F2
") # correlation must be estimated

set.seed(1)
cp_calib       <- mirt(d, m, itemtype = "graded")
cesd_items     <- 29:48                                         # 20 items, score range 0-60
cp_likelihoods <- LWrecursion(cp_calib, cesd_items, theta_grid) # takes a few minutes

est_cor <- as.data.frame(coef(cp_calib)$GroupPars)
est_cor <- est_cor[["COV_21"]]                                  # 0.9054712

sigma       <- diag(nd)
sigma[2, 1] <- est_cor
sigma[1, 2] <- est_cor

cp_eap  <- LtoEAP(cp_likelihoods, theta_grid, sigma)
cp_out  <- EAPtoTABLE(cp_eap, dimension = 1, tscore = FALSE)    # Get EAP for Factor 1 (PROMIS)
