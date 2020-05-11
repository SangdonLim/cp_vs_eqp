calcLevelProb <- function(itempool, theta, item_idx, score_level) {

  nj <- nrow(theta)
  p  <- rep(NA, nj)

  probs    <- mirt::probtrace(itempool, Theta = theta)
  itemname <- colnames(itempool@Data$data)[item_idx]
  tmp   <- sprintf("%s.P.%s", itemname, score_level + 1)
  probs <- probs[, tmp]

  return(probs)

}
