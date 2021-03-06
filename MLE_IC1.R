# D�termination des IC � 95% pour les param�tres des distributions de Weibull 

# Etape 1: d�termination des bornes max de IC � 95%

library("bbmle")

TAB1<-read.table("EX8A.csv", sep=";", dec=",", header=TRUE)


nl<-nrow(TAB1) # nombre de lignes � scruter

LIKIC95=function(alpha1,alpha2,alpha3,beta) {
  
  
  
  V<-numeric(nl)
  V<-0
  
  for (i in 1:nl) {
    
    if (TAB1[i,6]==2 && TAB1[i,1]==85) {   # Traitement des donn�es censur�es par intervalle
      
      V[i]<-TAB1[i,7]*log(pweibull(TAB1[i,5],beta,exp(alpha1),lower.tail=T,F)-pweibull(TAB1[i,4],beta,exp(alpha1),lower.tail=T,F)) 
      
    }
    
    if (TAB1[i,6]==1 && TAB1[i,1]==85) {   # Traitement des donn�es censur�es � droite
      
      
      V[i]<-TAB1[i,7]*log((1-pweibull(TAB1[i,4],beta,exp(alpha1),lower.tail=T,F)))
      
    }
    
    
    
    if (TAB1[i,6]==2 && TAB1[i,1]==105) {   # Traitement des donn�es censur�es par intervalle
      
      V[i]<-TAB1[i,7]*log(pweibull(TAB1[i,5],beta,exp(alpha2),lower.tail=T,F)-pweibull(TAB1[i,4],beta,exp(alpha2),lower.tail=T,F)) 
      
    }
    
    if (TAB1[i,6]==1 && TAB1[i,1]==105) {   # Traitement des donn�es censur�es � droite
      
      
      V[i]<-TAB1[i,7]*log((1-pweibull(TAB1[i,4],beta,exp(alpha2),lower.tail=T,F)))
      
    }
    
    if (TAB1[i,6]==2 && TAB1[i,1]==125) {   # Traitement des donn�es censur�es par intervalle
      
      V[i]<-TAB1[i,7]*log(pweibull(TAB1[i,5],beta,exp(alpha3),lower.tail=T,F)-pweibull(TAB1[i,4],beta,exp(alpha3),lower.tail=T,F)) 
      
    }
    
    if (TAB1[i,6]==1 && TAB1[i,1]==125) {   # Traitement des donn�es censur�es � droite
      
      
      V[i]<-TAB1[i,7]*log((1-pweibull(TAB1[i,4],beta,exp(alpha3),lower.tail=T,F)))
      
    }
    
  }
  
  return(-sum(V))
}



Res2<- mle2(LIKIC95,start=list(alpha1=5,alpha2=5,alpha3=5,beta=0.5))

print(Res2)
summary(Res2)

IC95<-confint(profile(Res1))

# conversion des param�tres
ALPHA<-IC95[-4,]
ALPHA<-exp(ALPHA)
par<-rbind(ALPHA,IC95[4,])

dimnames(par)[[1]][4]<-"beta"
#par<-exp(par)
cat("\n","Valeurs des param�tres:","\n")
print(par)




