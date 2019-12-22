# Détermination des fonctions de survie - Méthode MLE 
# 
# Chapitre 8 - Tobias - Ex8.3A
#
# Détermination fonction de vraissemblance
# sous hypothèse d'un facteur de forme commun

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


