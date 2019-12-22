# Etude du relevé chap8 - Tobias
library(survival)
library(icenReg)
TAB<-read.table("Chap81.csv", sep=";", dec=",", header=TRUE)
TAB85<-TAB[TAB$Temp==85,]
TAB105<-TAB[TAB$Temp==105,]
TAB125<-TAB[TAB$Temp==125,]
TAB$Temp<-as.factor(TAB$Temp)

# Température 85 degrés

attach(TAB85)
ob85<-with(TAB85,Surv(Start,End,type="interval2"))

fit85<- ic_par(cbind(Start, End) ~ 1, data = TAB85, model = "aft", dist = "weibull")

# Température 105 degrés
attach(TAB105)
ob105<-with(TAB105,Surv(Start,End,type="interval2"))
fit105<- ic_par(cbind(Start, End) ~ 1, data = TAB105, model = "aft", dist = "weibull")


# Température 125 degrés
attach(TAB125)
ob85<-with(TAB125,Surv(Start,End,type="interval2"))
fit125<- ic_par(cbind(Start, End) ~ 1, data = TAB125, model = "aft", dist = "weibull")

# Tracé des courbes de survie 85 degrés
np_fit = ic_np(cbind(Start, End) ~ 0, data = TAB85)
plot(np_fit, col = c("blue","orange"),xlab ="Time",ylab ="Estimated Survival")

# Tracé des courbes de survie 105 degrés
np_fit = ic_np(cbind(Start, End) ~ 0, data = TAB105)
plot(np_fit, col = c("blue","orange"),xlab ="Time",ylab ="Estimated Survival")

# Tracé des courbes de survie 125 degrés
np_fit = ic_np(cbind(Start, End) ~ 0, data = TAB125)
plot(np_fit, col = c("blue","orange"),xlab ="Time",ylab ="Estimated Survival")

detach(TAB)

# Méthode type="interval"
TAB1<-read.table("Chap82.csv", sep=";", dec=",", header=TRUE)

attach(TAB1)
TAB851<-TAB1[TAB1$Temp==85,]
TAB1051<-TAB1[TAB1$Temp==105,]
TAB1251<-TAB1[TAB1$Temp==125,]
ob851<-with(TAB851,Surv(Start,End,Status, type="interval"))

#m <- survreg(ob851~1, data = TAB851, dist = "weibull")

fit851<- ic_par(cbind(Start, End) ~ 1, data = TAB851, model = "aft", dist = "weibull")

