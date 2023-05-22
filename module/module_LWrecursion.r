# module/module_LWrecursion.r
# function for performing Lord-Wingersky recursion
# this obtains likelihoods of each score level over quadrature points

LWrecursion <- function(itempool, use_items, theta_grid) {

  L_init <- TRUE

  for (item_idx in use_items) {

    new_max_value_of_item <- itempool@Data$K[item_idx] - 1
    new_possible_values   <- 0:new_max_value_of_item

    P <- list()
    for (v in new_possible_values) {
      P[[as.character(v)]] <-
        computeResponseProbability(itempool, theta_grid, item_idx, v)
    }

    if (L_init) {

      L <- P
      old_possible_values <- new_possible_values
      L_init <- FALSE

    } else {

      map_values <- expand.grid(old_possible_values, new_possible_values)

      map_L <- do.call(rbind, L[as.character(map_values[, 1])])
      map_P <- do.call(rbind, P[as.character(map_values[, 2])])

      map_lls <- map_L * map_P

      tmp <- aggregate(map_lls, by = list(apply(map_values, 1, sum)), sum)

      tmp_lls   <- tmp[, -1]
      tmp_value <- tmp[, 1]

      L <- list()
      for (i in 1:nrow(tmp)) {
        L[[as.character(tmp_value[i])]] <-
          tmp_lls[i, ]
      }

      old_possible_values <- tmp[, 1]

    }

  }

  return(L)

}
