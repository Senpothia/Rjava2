# objective function
mix.obj <- function(p, x)
  {
    e <- p[1]/p[3] * dnorm( (x - p[2])/p[3] ) +
      (1-p[1])/p[5] * dnorm( (x - p[4])/p[5] )
    if(any(e <= 0)) Inf else -sum(log(e))
  }
# define initial values
p0 <- c(p = mean(1:24), u1 = 50, s1 = 5, u2 = 80, s2 = 5)

# optimize
mix.nl0 <- optim(p0, mix.obj, x = 1:24)