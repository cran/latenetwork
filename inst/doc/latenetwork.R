## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
options(rmarkdown.html_vignette.check_title = FALSE)

## ----setup, include = FALSE---------------------------------------------------
library(latenetwork)

## ---- eval = F, echo = T------------------------------------------------------
#  install.packages("latenetwork")

## ---- eval = F, echo = T------------------------------------------------------
#  # install.packages("devtools") # if needed
#  devtools::install_github("tkhdyanagi/latenetwork", build_vignettes = TRUE)

## ---- eval = F, echo = T------------------------------------------------------
#  # if needed --------------------------------------------------------------------
#  install.packages("igraph")

## ---- eval = T, echo = T------------------------------------------------------
# Generate artificial data from a ring network----------------------------------
set.seed(1)
n <- 2000
data <- latenetwork::datageneration(n = n)

## ---- eval = T, echo = T------------------------------------------------------
# Arguments --------------------------------------------------------------------
Y   <- data$Y
D   <- data$D
Z   <- data$Z
A   <- data$A
IEM <- ifelse(A %*% Z > 0, 1, 0)
S   <- rep(TRUE, n)
K   <- 1
z   <- 1
t   <- 0
t0  <- 0
t1  <- 1
bw  <- NULL
B   <- NULL
alp <- 0.05

# Causal inference -------------------------------------------------------------

# The ADE parameters defined by IEM = (A %*% Z > 0)
result_direct1 <- latenetwork::direct(Y = Y,
                                      D = D,
                                      Z = Z,
                                      IEM = IEM,
                                      S = S,
                                      A = A,
                                      K = K,
                                      t = t,
                                      bw = bw,
                                      B = B,
                                      alp = alp)

# The ADE parameters defined by the constant IEM
result_direct2 <- latenetwork::direct(Y = Y,
                                      D = D,
                                      Z = Z,
                                      IEM = NULL,
                                      S = S,
                                      A = A,
                                      K = K,
                                      t = NULL,
                                      bw = bw,
                                      B = B,
                                      alp = alp)

# The AIE parameters defined by K = 1
result_indirect <- latenetwork::indirect(Y = Y,
                                         D = D,
                                         Z = Z,
                                         S = S,
                                         A = A,
                                         K = K,
                                         bw = bw,
                                         B = B,
                                         alp = alp)

# The AOE parameters defined by K = 1
result_overall <- latenetwork::overall(Y = Y,
                                       D = D,
                                       Z = Z,
                                       S = S,
                                       A = A,
                                       K = K,
                                       bw = bw,
                                       B = B,
                                       alp = alp)

# The ASE parameters defined by IEM = (A %*% Z > 0)
result_spillover <- latenetwork::spillover(Y = Y,
                                           D = D,
                                           Z = Z,
                                           IEM = IEM,
                                           S = S,
                                           A = A,
                                           K = K,
                                           z = z,
                                           t0 = t0,
                                           t1 = t1,
                                           bw = bw,
                                           B = B,
                                           alp = alp)

## ---- eval = T, echo = T------------------------------------------------------
result_direct1

result_direct2

result_indirect

result_overall

result_spillover

