f <- function(x) {
  abs(x - 3.5) + (x - 2)^2
}
op <- optimize(f = f, interval = c(1, 5))
