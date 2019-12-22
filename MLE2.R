# Détermination des fonctions de survie - Méthode MLE 
# 
# Chapitre 8 - Tobias - Ex8.3A
#
# Détermination fonction de vraissemblance et estimation des paramètres loi de weibull
# sous hypothèse d'un facteur de forme commun
library("bbmle")
TAB1<-read.table("Chap81.csv", sep=";", dec=",", header=TRUE)


nl<-nrow(TAB1) # nombre de lignes à scruter

LIK=function(x) {
  
  
  
  V<-numeric(nl)
  V<-0
  
  for (i in 1:nl) {
    
    if (TAB1[i,4]==3 && TAB1[i,5]==85) {   # Traitement des données censurées par intervalle
      
      V[i]<-log(pweibull(TAB1[i,3],x[4],exp(x[1]),lower.tail=T,F)-pweibull(TAB1[i,2],x[4],exp(x[1]),lower.tail=T,F)) 
      
                                        }
    
    if (TAB1[i,4]==0 && TAB1[i,5]==85) {   # Traitement des données censurées à droite
      
      
      V[i]<-log((1-pweibull(TAB1[i,2],x[4],exp(x[1]),lower.tail=T,F)))
      
                                       }
    
    
    
    if (TAB1[i,4]==3 && TAB1[i,5]==105) {   # Traitement des données censurées par intervalle
      
      V[i]<-log(pweibull(TAB1[i,3],x[4],exp(x[2]),lower.tail=T,F)-pweibull(TAB1[i,2],x[4],exp(x[2]),lower.tail=T,F)) 
      
                                         }
    
    if (TAB1[i,4]==0 && TAB1[i,5]==105) {   # Traitement des données censurées à droite
      
      
      V[i]<-log((1-pweibull(TAB1[i,2],x[4],exp(x[2]),lower.tail=T,F)))
      
                                        }
    
    if (TAB1[i,4]==3 && TAB1[i,5]==125) {   # Traitement des données censurées par intervalle
      
      V[i]<-log(pweibull(TAB1[i,3],x[4],exp(x[3]),lower.tail=T,F)-pweibull(TAB1[i,2],x[4],exp(x[3]),lower.tail=T,F)) 
      
    }
    
    if (TAB1[i,4]==0 && TAB1[i,5]==125) {   # Traitement des données censurées à droite
      
      
      V[i]<-log((1-pweibull(TAB1[i,2],x[4],exp(x[3]),lower.tail=T,F)))
      
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


cat("\n","alpha1=",exp(Res$par[1]),"\n")
cat("alpha2=",exp(Res$par[2]),"\n")
cat("alpha3=",exp(Res$par[3]),"\n")
cat("beta=",Res$par[4],"\n")

# Graphe des fonctions de survie
jpeg('mle2.jpg')
curve(1-pweibull(x,beta,alpha1),from=0,to=5000,col="blue",xlab="Time", ylab="Probability",main="CDF survie")

curve(1-pweibull(x,beta,alpha2),col="red",add=TRUE)


curve(1-pweibull(x,beta,alpha3),col="green",add=TRUE)

legend("topright",legend=c("85°C","105°C","125°C"),col=c("blue","red","green"),lty=c(1,1,1))

