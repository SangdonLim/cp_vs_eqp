# module/module_grid.r
# creates quadrature points over two-dimensional space

nd         <- 2
theta      <- seq(-4.5, 4.5, .2)
theta_grid <- as.matrix(expand.grid(theta, theta))
n_grid     <- dim(theta_grid)[1]
