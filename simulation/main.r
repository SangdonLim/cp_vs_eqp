# simulation/main.r
# main simulation script

library(mvnfast)
library(mirt)
library(parallel)
library(foreach)
library(doParallel)

n_cores <- detectCores() - 2
cl      <- makeCluster(n_cores)
registerDoParallel(cl)

root <- rprojroot::find_rstudio_root_file()

source(file.path(root, "module/module_grid.r"))
source(file.path(root, "module/module_computeResponseProbability.r"))
source(file.path(root, "module/module_LWrecursion.r"))
source(file.path(root, "module/module_LtoEAP.r"))
source(file.path(root, "module/module_EAPtoTABLE.r"))

source(file.path(root, "simulation/make_item_parameters.r"))
source(file.path(root, "simulation/generate_data.r"))
source(file.path(root, "simulation/perform_EQP.r"))
source(file.path(root, "simulation/perform_CP.r"))
source(file.path(root, "simulation/evaluate_performance.r"))

cesd_items <- 29:48

c1      <- seq(.95, .50, -.05)
c2      <- 1:20
conditions <- expand.grid(c1, c2)
n_conditions <- nrow(conditions)

out <- foreach(
  idx_condition = 1:n_conditions,
  .packages = c("mvnfast", "PROsetta", "mirt")) %dopar% {

  true_corr <- conditions[idx_condition, 1]
  idx_trial <- conditions[idx_condition, 2]

  set.seed(idx_trial)

  X <- get_data(true_corr, ipar_a, ipar_d)

  table_EQP  <- perform_EQP(X)
  table_CP   <- perform_CP(X, theta_grid)

  X_promis <- X$data
  X_promis[, cesd_items] <- NA
  pattern_1D <- fscores(
    table_EQP$eq_calib,
    response.pattern = X_promis,
    append_response.pattern = FALSE
  )[, 1]

  table_EQP <- table_EQP$eq_conc
  table_out <- evaluate_performance(X, table_EQP, table_CP, pattern_1D)

  fn <- sprintf("out_%s_%s.csv", true_corr, idx_trial)

  write.csv(table_out, file.path("results", fn), row.names = FALSE)

  NULL

}

stopCluster(cl)
