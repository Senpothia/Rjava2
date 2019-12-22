library(foreign)
library(ggplot2)
library(GGally)
library(survival)
library(rgl)
dat <- read.dta("http://www.karlin.mff.cuni.cz/~pesta/prednasky/NMFM404/Data/intreg_data.dta")

# bivariate plots
ggpairs(dat[, -1], lower = list(combo = "box"), upper = list(combo = "blank"))
by(dat[, 2:5], dat$type, colMeans, na.rm = TRUE)

Y <- with(dat, Surv(lgpa, ugpa, event = rep(3, nrow(dat)), type = "interval"))
m <- survreg(Y ~ write + rating + type, data = dat, dist = "gaussian")
