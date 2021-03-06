# Traitement sur les donn�es de chap8 - Tobias - fichier du jeu de donn�es Ex8A.xls
# Hypoth�se de facteurs de forme diff�rents
#(pour facteurs de forme diff�rents voir fichier: Sim2.R)
library(icenReg)
library(ICBayes)
library(bbmle)
TAB1<-read.table("Chap8-85.csv", sep=";", dec=",", header=TRUE)

attach(TAB1)

ob<-Surv(Start,End, type="interval2")
#fit<- ic_par(cbind(Start, End)~1, model = "aft", dist = "weibull")
fit1<- ic_par(ob ~ 1, model = "aft", dist = "weibull") # R�sultat concordants p251
print(fit1)
# fit1<-survreg(ob~ 1, dist = "weibull")
detach(TAB1)
TAB2<-read.table("Chap8-105.csv", sep=";", dec=",", header=TRUE)

attach(TAB2)

ob2<-Surv(Start,End, type="interval2")

fit2<- ic_par(ob2 ~ 1, model = "aft", dist = "weibull") # R�sultat concordants p251
print(fit2)
detach(TAB2)
TAB3<-read.table("Chap8-125.csv", sep=";", dec=",", header=TRUE)

attach(TAB3)

ob3<-Surv(Start,End, type="interval2")

fit3<- ic_par(ob3 ~ 1, model = "aft", dist = "weibull") # R�sultat concordants p251
print(fit3)
detach(TAB3)

llk<-c(fit1$llk,fit2$llk,fit3$llk)  # Liste des vraissemblances de chaque groupe
L1<-sum(llk)                        # Somme des vraissemblance de chaque groupe

# Estimation bayesienne des param�tres
#attach(TAB1)
#Temp<-as.factor(TAB1$Temp)
#fb1<-ic_bayes(cbind(Start, End)~Temp, data=TAB1, model = "aft", dist = "weibull")

