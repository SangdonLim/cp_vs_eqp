library(stringr)

root <- rprojroot::find_rstudio_root_file()

f_all <- list.files(file.path(root, "results"))
corr <- seq(0.95, 0.50, -0.05)
out_all <- as.data.frame(matrix(NA, 0, 3))

for (r in corr) {
  tmp <- sprintf("out_%s_", r)
  idx <- str_detect(f_all, tmp)
  fs  <- f_all[idx]

  out <- as.data.frame(matrix(NA, length(fs), 4))

  for (i in 1:length(fs)) {

    d <- read.csv(file.path(root, "results", fs[i]))
    diff_eqp <- d$prom_theta_eqp - d$prom_theta
    diff_cp  <- d$prom_theta_cp  - d$prom_theta
    diff_pat <- d$prom_pattern   - d$prom_theta
    rmse_eqp <- sqrt(mean((diff_eqp)**2))
    rmse_cp  <- sqrt(mean((diff_cp )**2))
    rmse_pat <- sqrt(mean((diff_pat)**2))
    out[i, ] <- c(r, rmse_eqp, rmse_cp, rmse_pat)

  }

  out_all <- rbind(out_all, out)

}

out_avg <- aggregate(
  out_all, by = list(out_all[, 1]),
  function(x) sqrt(mean(x**2)))[, -1]

plot(
  out_avg[, 1], out_avg[, 1], type = "n",
  xlab = "Latent correlation", ylab = "RMSE",
  xlim = c(1.0, 0.5),
  ylim = c(0.2, 1.1))

grid()

lines(out_avg[, 1], out_avg[, 2], col = "red")
lines(out_avg[, 1], out_avg[, 3], col = "blue")
lines(out_avg[, 1], out_avg[, 4], col = "red", lty = 2)

legend("topleft",
  c("Equipercentile", "Calibrated projection", "1D pattern"),
  col = c("red", "blue", "red"),
  lty = c(1, 1, 2))
