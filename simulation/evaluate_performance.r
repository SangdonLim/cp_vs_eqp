# simulation/evaluate_performance.r
# evaluates simulation performance from one replication

evaluate_performance <- function(X, table_EQP, table_CP, pattern_1D) {
  out <- data.frame(
    cesd_raw     = apply(X$data[, cesd_items], 1, sum),
    cesd_theta   = X$theta[, 2],
    prom_theta   = X$theta[, 1],
    prom_pattern = pattern_1D)
  out <- merge(out, table_EQP, by.x = "cesd_raw", by.y = "raw_2")
  out <- out[, 1:5]
  colnames(out)[5] <- "promis_theta_eqp"
  out <- merge(out, table_CP , by.x = "cesd_raw", by.y = "x")
  out <- out[, 1:6]
  colnames(out)[6] <- "promis_theta_cp"

  return(out)
}
