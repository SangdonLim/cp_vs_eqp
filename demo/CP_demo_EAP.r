# demo/CP_demo_EAP.r
# converts likelihood values of PedsQL instrument
# into two-dimensional theta estimates

est_cor     <- .96
sigma       <- diag(nd)
sigma[2, 1] <- est_cor
sigma[1, 2] <- est_cor

EAP <- LtoEAP(L, theta_grid, sigma)
