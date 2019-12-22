library(survival)

#on crée un jeu de données correspondant à des durées (étudiées dans l'analyse de survie)

 z<-c(14,14,14,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,23)
d<-data.frame(delay=z)

#on crée une colonne status, ici tous les individus sont "morts" pendant l'expérience 
# mort au sens de l'analyse de survie

 d$status<-1 

 s<-survfit(Surv(d$delay,d$status)~1)
plot(s,main="survival function")
jpeg('kaplan.jpg')
plot(s,main="survival function")
dev.off()