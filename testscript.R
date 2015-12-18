setwd("C:\\Users\\jcale\\Documents\\GitHub\\RepData_PeerAssessment1")
act<-read.csv("activity\\activity.csv")
act<-na.omit(act)

actagg<-aggregate(act$steps,list(act$date),FUN=sum)

names(actagg)<-c("date","steps")
hist(actagg$steps,xlab="Steps",main="Steps per day")

mean(actagg$steps)
median(actagg$steps)

actagg1<-aggregate(act$steps,list(act$interval),FUN=mean)
plot(actagg1,type="l",xlab='Interval',ylab="steps")

#5 minute interval with most steps
actagg1[actagg1$x==max(actagg1$x),1]

act<-read.csv("activity\\activity.csv")
sum(is.na(act))
