# D�termination des fonctions de survie - M�thode MLE 
# 
# Chapitre 8 - Tobias - Ex8.3A
#
# D�termination fonction de vraissemblance et estimation des param�tres loi de Weibull 
# sous hypoth�se d'un facteur de forme commun
# (pour facteurs de forme diff�rents voir fichier: Sim2.R)
# Fichier cvs au format Tobias

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

curve(1-pweibull(x,beta,alpha1),from=0,to=5000,col="blue",xlab="Time", ylab="Probability",main="CDF survie")

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


cat("\n")
cat("Vraissemblance sous hypoth�se de facteurs de forme diff�rents; L2=",LIK(),"\n")


