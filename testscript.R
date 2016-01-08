setwd("C:\\Users\\calej\\Documents\\GitHub\\RepData_PeerAssessment1")
act<-read.csv("activity\\activity.csv")


aggdate<-aggregate(act$steps,list(act$date),FUN=sum)

names(aggdate)<-c("date","steps")
hist(aggdate$steps,xlab="Steps",main="Steps per day")

mean(aggdate$steps,na.rm=TRUE)
median(aggdate$steps,na.rm=TRUE)
act<-na.omit(act)
agginterval<-aggregate(act$steps,list(act$interval),FUN=mean)

plot(agginterval,type="l",xlab='Interval',ylab="steps")

#5 minute interval with most steps
agginterval[agginterval$x==max(agginterval$x),1]

act<-read.csv("activity\\activity.csv")

sum(is.na(act))
act<-na.omit(act)


names(agginterval)<-c("interval","stepavg")
act<-merge(act,agginterval,by=c("interval"))
act$steps[is.na(act$steps)] <- act$stepavg[is.na(act$steps)]

aggdate2<-aggregate(act$steps,list(act$date),FUN=sum)
names(aggdate2)<-c("date","steps")
hist(aggdate2$steps,xlab="Steps",main="Steps per day")

mean(aggdate2$steps)
median(aggdate2$steps)

act$date <- as.Date(act$date)
weekdays1 <- c('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday')
act$weekday <- c('weekend', 'weekday')[(weekdays(act$date) %in% weekdays1)+1L]
aggweekday<-aggregate(act$steps,list(act$interval,act$weekday),FUN=mean)
names(aggweekday)<-c("interval","weekday","stepavg")
with(aggweekday[aggweekday$weekday=="weekday",],plot(interval,stepavg,type="l"))
with(aggweekday[aggweekday$weekday=="weekend",],lines(interval,stepavg,type="l",col = "red"))
