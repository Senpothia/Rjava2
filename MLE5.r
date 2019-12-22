#
# Détermination des fonctions de survie - Méthode MLE 
# 
# Chapitre 8 - Tobias - Ex8.3A
#
# Détermination fonction de vraissemblance et estimation des paramètres loi de Weibull 
# sous hypothèse d'un facteur de forme commun
# (pour facteurs de forme différents voir fichier: Sim2.R)
# Fichier cvs au format Tobias
#
# Graphe des fonctions de survie d'après les paramètres estimés et test du rapport de vraissemblance 
# pour évaluer la valididité de l'hypothèse d'un facteur de forme commun
library(icenReg)
library(ICBayes)
library(bbmle)
TAB1<-read.table("EX8A.csv", sep=";", dec=",", header=TRUE)


nl<-nrow(TAB1) # nombre de lignes à scruter

LIK=function(x) {
  
  
  
  V<-numeric(nl)
  V<-0
  
  for (i in 1:nl) {
    
    if (TAB1[i,6]==2 && TAB1[i,1]==85) {   # Traitement des données censurées par intervalle
      
      V[i]<-TAB1[i,7]*log(pweibull(TAB1[i,5],x[4],exp(x[1]),lower.tail=T,F)-pweibull(TAB1[i,4],x[4],exp(x[1]),lower.tail=T,F)) 
      
    }
    
    if (TAB1[i,6]==1 && TAB1[i,1]==85) {   # Traitement des données censurées à droite
      
      
      V[i]<-TAB1[i,7]*log((1-pweibull(TAB1[i,4],x[4],exp(x[1]),lower.tail=T,F)))
      
    }
    
    
    
    if (TAB1[i,6]==2 && TAB1[i,1]==105) {   # Traitement des données censurées par intervalle
      
      V[i]<-TAB1[i,7]*log(pweibull(TAB1[i,5],x[4],exp(x[2]),lower.tail=T,F)-pweibull(TAB1[i,4],x[4],exp(x[2]),lower.tail=T,F)) 
      
    }
    
    if (TAB1[i,6]==1 && TAB1[i,1]==105) {   # Traitement des données censurées à droite
      
      
      V[i]<-TAB1[i,7]*log((1-pweibull(TAB1[i,4],x[4],exp(x[2]),lower.tail=T,F)))
      
    }
    
    if (TAB1[i,6]==2 && TAB1[i,1]==125) {   # Traitement des données censurées par intervalle
      
      V[i]<-TAB1[i,7]*log(pweibull(TAB1[i,5],x[4],exp(x[3]),lower.tail=T,F)-pweibull(TAB1[i,4],x[4],exp(x[3]),lower.tail=T,F)) 
      
    }
    
    if (TAB1[i,6]==1 && TAB1[i,1]==125) {   # Traitement des données censurées à droite
      
      
      V[i]<-TAB1[i,7]*log((1-pweibull(TAB1[i,4],x[4],exp(x[3]),lower.tail=T,F)))
      
    }
    
  }
  
  return(-sum(V))
}



# Optimisation - Détermination des paramètres

p0<-c(5,5,5,1)
Res<- optim(p0, LIK)

alpha1<-exp(Res$par[1])
alpha2<-exp(Res$par[2])
alpha3<-exp(Res$par[3])
beta<-exp(Res$par[4])

cat("\n")
cat("alpha1=",exp(Res$par[1]),"--JMP: 12270.3","\n")
cat("alpha2=",exp(Res$par[2]),"--JMP: 1849.2","\n")
cat("alpha3=",exp(Res$par[3]),"--JMP: 228.9","\n")
cat("beta=",Res$par[4],"--JMP: 0.72293","\n")

# Graphe des fonctions de survie
jpeg('mle5.jpg')
curve(1-pweibull(x,beta,alpha1),from=1,to=1000000,col="blue",xlab="Time", ylab="Probability",main="Fonctions de survie",log="x")

curve(1-pweibull(x,beta,alpha2),col="red",add=TRUE)

curve(1-pweibull(x,beta,alpha3),col="green",add=TRUE)

legend("bottomleft",legend=c("85°C","105°C","125°C"),col=c("blue","red","green"),lty=c(1,1,1))

# Evaluation de la vraissemble sous hypothèse d'un facteur de forme commun d'après les paramètres estimés

#           Détermination des fonctions de survie - Méthode MLE 
# 
#           Chapitre 8 - Tobias - Ex8.3A
#
#           Détermination fonction de vraissemblance
#           sous hypothèse d'un facteur de forme commun

TAB1<-read.table("Chap811.csv", sep=";", dec=",", header=TRUE)

# Chap81.csv correspond au fichier contenant les paramètres sous hypothèse d'un facteur de forme commun.
# Les paramètres sous hypothèse d'un facteur de forme commun sont évalués par MLE3.R


nl<-nrow(TAB1) # nombre de lignes à scruter

LIK=function() {
  
  
  
  V<-numeric(nl)
  V<-0
  
  for (i in 1:nl) {
    
    if (TAB1[i,4]==3) {   # Traitement des données censurées par intervalle
      
      V[i]<-log(pweibull(TAB1[i,3],TAB1[i,7],exp(TAB1[i,6]),lower.tail=T,F)-pweibull(TAB1[i,2],TAB1[i,7],exp(TAB1[i,6]),lower.tail=T,F)) 
      
    }
    
    if (TAB1[i,4]==0) {   # Traitement des données censurées à droite
      
      
      V[i]<-log((1-pweibull(TAB1[i,2],TAB1[i,7],exp(TAB1[i,6]),lower.tail=T,F)))
      
    }
    
  }
  
  return(-sum(V))
}

L2<-LIK()
cat("\n")
cat("Vraissemblance sous hypothèse de facteurs de forme différents; L2=",L2,"\n")


# Traitement des données sous hypothèses des distributions indépendantes

# Traitement sur les données de chap8 - Tobias - fichier du jeu de données Ex8A.xls
# Hypothèse de facteurs de forme différents
#(pour facteurs de forme différents voir fichier: Sim2.R)

TAB1<-read.table("Chap8-85.csv", sep=";", dec=",", header=TRUE)

attach(TAB1)

ob<-Surv(Start,End, type="interval2")
#fit<- ic_par(cbind(Start, End)~1, model = "aft", dist = "weibull")
fit1<- ic_par(ob ~ 1, model = "aft", dist = "weibull") # Résultat concordants p251
print(fit1)
# fit1<-survreg(ob~ 1, dist = "weibull")
detach(TAB1)
TAB2<-read.table("Chap8-105.csv", sep=";", dec=",", header=TRUE)

attach(TAB2)

ob2<-Surv(Start,End, type="interval2")

fit2<- ic_par(ob2 ~ 1, model = "aft", dist = "weibull") # Résultat concordants p251
print(fit2)
detach(TAB2)
TAB3<-read.table("Chap8-125.csv", sep=";", dec=",", header=TRUE)

attach(TAB3)

ob3<-Surv(Start,End, type="interval2")

fit3<- ic_par(ob3 ~ 1, model = "aft", dist = "weibull") # Résultat concordants p251
print(fit3)
detach(TAB3)
llk1<-c(fit1$llk,fit2$llk,fit3$llk)  # Liste des vraissemblances de chaque groupe sous hypothèse de facteurs de forme différents
L1<-(-1*(fit1$llk+fit2$llk+fit3$llk))

cat("\n","Vraissemblance sous hypothèse de distributions différentes: L1=",L1," ---Minitab: 196.788. Voir exemple 8.3 page 257 ou 251 ")
cat("\n","Vraissemblance sous hypothèse de facteur de forme commun: L2=",L2," ---Minitab: 197.160. Voir idem, page 257. Attention les appellations sont inversées!") 

# Test du rapport de vraissemblance - Vérification de la significativité du facteur de forme commun

if (L1<L2) LRT<-2*(L2-L1) else LRT<-2*(L1-L2)

#LRT<-2*(L1-L2)
pc<-qchisq(0.95,2,ncp=0,lower.tail = T) # Probabilité critique; ncp=0 (distribution centrée); lower.tail (P[x<q])

pval_LRT<- 1-pchisq(LRT,2,ncp=0,lower.tail = T)

cat("\n", "Test du rapport de vraissemblance, LRT:",LRT," pvalue:",pval_LRT,"\n")

# Détermination des IC à 95% pour les paramètres des distributions de Weibull 

# Etape 1: détermination des bornes max de IC à 95%



TAB1<-read.table("EX8A.csv", sep=";", dec=",", header=TRUE)


nl<-nrow(TAB1) # nombre de lignes à scruter

LIKIC95=function(alpha1,alpha2,alpha3,beta) {
  
  
  
  V<-numeric(nl)
  V<-0
  
  for (i in 1:nl) {
    
    if (TAB1[i,6]==2 && TAB1[i,1]==85) {   # Traitement des données censurées par intervalle
      
      V[i]<-TAB1[i,7]*log(pweibull(TAB1[i,5],beta,exp(alpha1),lower.tail=T,F)-pweibull(TAB1[i,4],beta,exp(alpha1),lower.tail=T,F)) 
      
    }
    
    if (TAB1[i,6]==1 && TAB1[i,1]==85) {   # Traitement des données censurées à droite
      
      
      V[i]<-TAB1[i,7]*log((1-pweibull(TAB1[i,4],beta,exp(alpha1),lower.tail=T,F)))
      
    }
    
    
    
    if (TAB1[i,6]==2 && TAB1[i,1]==105) {   # Traitement des données censurées par intervalle
      
      V[i]<-TAB1[i,7]*log(pweibull(TAB1[i,5],beta,exp(alpha2),lower.tail=T,F)-pweibull(TAB1[i,4],beta,exp(alpha2),lower.tail=T,F)) 
      
    }
    
    if (TAB1[i,6]==1 && TAB1[i,1]==105) {   # Traitement des données censurées à droite
      
      
      V[i]<-TAB1[i,7]*log((1-pweibull(TAB1[i,4],beta,exp(alpha2),lower.tail=T,F)))
      
    }
    
    if (TAB1[i,6]==2 && TAB1[i,1]==125) {   # Traitement des données censurées par intervalle
      
      V[i]<-TAB1[i,7]*log(pweibull(TAB1[i,5],beta,exp(alpha3),lower.tail=T,F)-pweibull(TAB1[i,4],beta,exp(alpha3),lower.tail=T,F)) 
      
    }
    
    if (TAB1[i,6]==1 && TAB1[i,1]==125) {   # Traitement des données censurées à droite
      
      
      V[i]<-TAB1[i,7]*log((1-pweibull(TAB1[i,4],beta,exp(alpha3),lower.tail=T,F)))
      
    }
    
  }
  
  return(-sum(V))
}



Res1<- mle2(LIKIC95,start=list(alpha1=9,alpha2=7,alpha3=5,beta=1))

print(Res1)
summary(Res1)

IC95<-confint(profile(Res1))
cat("\n","Logarithmes des paramètres alpha et valeur de beta:","\n")
print(IC95)

# conversion des paramètres
ALPHA<-IC95[-4,]
ALPHA<-exp(ALPHA)
par<-rbind(ALPHA,IC95[4,])

dimnames(par)[[1]][4]<-"beta"
#par<-exp(par)
cat("\n","Valeurs des paramètres:","\n")
print(par)
