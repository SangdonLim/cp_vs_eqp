# sim_generate_data.r
# generate true thetas and response data to use in simulation

get_data <- function(theta_corr, ipar_a, ipar_d) {

  nd    <- 2
  sigma <- matrix(theta_corr, nd, nd)
  diag(sigma) <- 1

  true_theta <- rmvn(1000, rep(0, 2), sigma)
  true_theta <- as.matrix(true_theta)

  response <- mirt::simdata(ipar_a, ipar_d, itemtype = "graded", Theta = true_theta)

  X <- list(
    data  = response,
    theta = true_theta
  )
  return(X)

}
