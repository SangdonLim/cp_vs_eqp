# module/module_computeResponseProbability.r
# function for computing category response probability
# at a given theta point

computeResponseProbability <- function(
  itempool, theta, item_idx, score_level
) {

  n_examinees <- nrow(theta)
  p           <- rep(NA, n_examinees)

  probs       <- mirt::probtrace(itempool, Theta = theta)
  itemname    <- colnames(itempool@Data$data)[item_idx]
  use_these   <- sprintf("%s.P.%s", itemname, score_level + 1)
  probs       <- probs[, use_these]

  return(probs)

}
