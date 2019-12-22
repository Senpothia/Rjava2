

x<-c(1,2,3,4,5,6,7,8,9,10)
y<-c(14, 12, 17, 25, 28, 24, 24, 28, 32, 32)
model<-lm(y~x)
jpeg('reg.jpg')
plot(x,y)
abline(model)
segments(x,fitted(model),x,y)
pred.frame<-data.frame(Age=1:10)
pc<-predict(model, interval="confidence", newdata=pred.frame)
pp<-predict(model, interval="prediction", newdata=pred.frame)
matlines(pred.frame, pc[,2:3], lty=c(2,2), col="blue")
matlines(pred.frame, pp[,2:3], lty=c(3,3), col="red")
legend("topleft",c("confiance","prediction"),lty=c(2,3), col=c("blue","red"))
dev.off()
res<-coef(model)
x<-c(res[0],res[1],res[2])
write.csv(x, file = "reg.csv", row.names = FALSE)