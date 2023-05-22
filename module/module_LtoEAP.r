# module/module_LtoEAP.r
# converts likelihoods obtained from Lord-Wingersky recursion
# into two-dimensional EAP estimates

LtoEAP <- function(L, theta_grid, sigma) {

  nd  <- dim(theta_grid)[2]
  tmp <- list()

  for (i in 1:length(L)) {

    num <- matrix(0, 1, nd)
    den <- 0

    for (j in 1:n_grid) {
      term_T <- theta_grid[j, , drop = FALSE]
      term_L <- as.numeric(L[[i]][j])
      term_W <- dmvn(term_T, rep(0, nd), sigma)
      num <- num + (term_T * term_L * term_W)
      den <- den + (term_L * term_W)
    }

    th <- num / den

    num <- matrix(0, nd, nd)
    den <- 0

    for (j in 1:n_grid) {
      term_T <- theta_grid[j, , drop = FALSE]
      term_C <- (term_T - th)
      term_V <- t(term_C) %*% term_C
      term_L <- as.numeric(L[[i]][j])
      term_W <- dmvn(term_T, rep(0, nd), sigma)
      num <- num + (term_V * term_L * term_W)
      den <- den + (term_L * term_W)
    }

    COV <- num / den

    tmp[[names(L)[i]]]$EAP <- th
    tmp[[names(L)[i]]]$COV <- COV

  }

  return(tmp)

}
