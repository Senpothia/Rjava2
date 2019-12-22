# Estimation bayesienne des paramètres

library(icenReg)
library(ICBayes)

TAB1<-read.table("Chap8-85_1.csv", sep=";", dec=",", header=TRUE)
attach(TAB1)
ob<-with(TAB1,Surv(Start,End, type="interval2"))
fb1<-ic_bayes(ob ~ 1, model = "po", dist = "weibull")



