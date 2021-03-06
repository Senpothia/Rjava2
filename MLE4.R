#
# D�termination des fonctions de survie - M�thode MLE 
# 
# Chapitre 8 - Tobias - Ex8.3A
#
# D�termination fonction de vraissemblance et estimation des param�tres loi de Weibull 
# sous hypoth�se d'un facteur de forme commun
# (pour facteurs de forme diff�rents voir fichier: Sim2.R)
# Fichier cvs au format Tobias
#
# Graphe des fonctions de survie d'apr�s les param�tres estim�s et test du rapport de vraissemblance 
# pour �valuer la valididit� de l'hypoth�se d'un facteur de forme commun

TAB1<-read.table("EX8A.csv", sep=";", dec=",", header=TRUE)


nl<-nrow(TAB1) # nombre de lignes � scruter

LIK=function(x) {
  
  
  
  V<-numeric(nl)
  V<-0
  
  for (i in 1:nl) {
    
    if (TAB1[i,6]==2 && TAB1[i,1]==85) {   # Traitement des donn�es censur�es par intervalle
      
      V[i]<-TAB1[i,7]*log(pweibull(TAB1[i,5],x[4],exp(x[1]),lower.tail=T,F)-pweibull(TAB1[i,4],x[4],exp(x[1]),lower.tail=T,F)) 
      
    }
    
    if (TAB1[i,6]==1 && TAB1[i,1]==85) {   # Traitement des donn�es censur�es � droite
      
      
      V[i]<-TAB1[i,7]*log((1-pweibull(TAB1[i,4],x[4],exp(x[1]),lower.tail=T,F)))
      
    }
    
    
    
    if (TAB1[i,6]==2 && TAB1[i,1]==105) {   # Traitement des donn�es censur�es par intervalle
      
      V[i]<-TAB1[i,7]*log(pweibull(TAB1[i,5],x[4],exp(x[2]),lower.tail=T,F)-pweibull(TAB1[i,4],x[4],exp(x[2]),lower.tail=T,F)) 
      
    }
    
    if (TAB1[i,6]==1 && TAB1[i,1]==105) {   # Traitement des donn�es censur�es � droite
      
      
      V[i]<-TAB1[i,7]*log((1-pweibull(TAB1[i,4],x[4],exp(x[2]),lower.tail=T,F)))
      
    }
    
    if (TAB1[i,6]==2 && TAB1[i,1]==125) {   # Traitement des donn�es censur�es par intervalle
      
      V[i]<-TAB1[i,7]*log(pweibull(TAB1[i,5],x[4],exp(x[3]),lower.tail=T,F)-pweibull(TAB1[i,4],x[4],exp(x[3]),lower.tail=T,F)) 
      
    }
    
    if (TAB1[i,6]==1 && TAB1[i,1]==125) {   # Traitement des donn�es censur�es � droite
      
      
      V[i]<-TAB1[i,7]*log((1-pweibull(TAB1[i,4],x[4],exp(x[3]),lower.tail=T,F)))
      
    }
    
  }
  
  return(-sum(V))
}



# Optimisation - D�termination des param�tres

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

curve(1-pweibull(x,beta,alpha1),from=0,to=10000,col="blue",xlab="Time", ylab="Probability",main="CDF survie")

curve(1-pweibull(x,beta,alpha2),col="red",add=TRUE)

curve(1-pweibull(x,beta,alpha3),col="green",add=TRUE)

legend("topright",legend=c("85�C","105�C","125�C"),col=c("blue","red","green"),lty=c(1,1,1))

# Evaluation de la vraissemble sous hypoth�se d'un facteur de forme commun d'apr�s les param�tres estim�s

#           D�termination des fonctions de survie - M�thode MLE 
# 
#           Chapitre 8 - Tobias - Ex8.3A
#
#           D�termination fonction de vraissemblance
#           sous hypoth�se d'un facteur de forme commun

TAB1<-read.table("Chap811.csv", sep=";", dec=",", header=TRUE)

# Chap81.csv correspond au fichier contenant les param�tres sous hypoth�se d'un facteur de forme commun.
# Les param�tres sous hypoth�se d'un facteur de forme commun sont �valu�s par MLE3.R


nl<-nrow(TAB1) # nombre de lignes � scruter

LIK=function() {
  
  
  
  V<-numeric(nl)
  V<-0
  
  for (i in 1:nl) {
    
    if (TAB1[i,4]==3) {   # Traitement des donn�es censur�es par intervalle
      
      V[i]<-log(pweibull(TAB1[i,3],TAB1[i,7],exp(TAB1[i,6]),lower.tail=T,F)-pweibull(TAB1[i,2],TAB1[i,7],exp(TAB1[i,6]),lower.tail=T,F)) 
      
    }
    
    if (TAB1[i,4]==0) {   # Traitement des donn�es censur�es � droite
      
      
      V[i]<-log((1-pweibull(TAB1[i,2],TAB1[i,7],exp(TAB1[i,6]),lower.tail=T,F)))
      
    }
    
  }
  
  return(-sum(V))
}

L2<-LIK()
cat("\n")
cat("Vraissemblance sous hypoth�se de facteurs de forme diff�rents; L2=",L2,"\n")


# Traitement des donn�es sous hypoth�ses des distributions ind�pendantes

# Traitement sur les donn�es de chap8 - Tobias - fichier du jeu de donn�es Ex8A.xls
# Hypoth�se de facteurs de forme diff�rents
#(pour facteurs de forme diff�rents voir fichier: Sim2.R)
library(icenReg)
library(ICBayes)
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
llk1<-c(fit1$llk,fit2$llk,fit3$llk)  # Liste des vraissemblances de chaque groupe sous hypoth�se de facteurs de forme diff�rents
L1<-(-1*(fit1$llk+fit2$llk+fit3$llk))

cat("\n","Vraissemblance sous hypoth�se de distributions diff�rentes: L1=",L1," ---Minitab: 196.788. Voir exemple 8.3 page 257 ou 251 ")
cat("\n","Vraissemblance sous hypoth�se de facteur de forme commun: L2=",L2," ---Minitab: 197.160. Voir idem, page 257. Attention les appellations sont invers�es!") 

# Test du rapport de vraissemblance - V�rification de la significativit� du facteur de forme commun

if (L1<L2) LRT<-2*(L2-L1) else LRT<-2*(L1-L2)

#LRT<-2*(L1-L2)
pc<-qchisq(0.95,2,ncp=0,lower.tail = T) # Probabilit� critique; ncp=0 (distribution centr�e); lower.tail (P[x<q])

pval_LRT<- 1-pchisq(LRT,2,ncp=0,lower.tail = T)

cat("\n", "Test du rapport de vraissemblance, LRT:",LRT," pvalue:",pval_LRT,"\n")






