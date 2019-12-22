# Simulation 
set.seed(123)
x<-rweibull(50, shape=5, scale = 1000)
l<-x-runif(50,6,30)
if (l<0) l=0
r<-x+runif(50,6,50)
s<-rep(3,50)
ob<-Surv(l,r,s, type="interval")
fit<- ic_par(cbind(l, r) ~ 1, model = "aft", dist = "weibull")
print(fit)
