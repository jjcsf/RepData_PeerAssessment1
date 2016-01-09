# Reproducible Research: Peer Assessment 1


## Loading and preprocessing the data

```r
setwd("C:\\Users\\calej\\Documents\\GitHub\\RepData_PeerAssessment1")
act<-read.csv("activity\\activity.csv")
act<-na.omit(act)

aggdate<-aggregate(act$steps,list(act$date),FUN=sum)

names(aggdate)<-c("date","steps")
agginterval<-aggregate(act$steps,list(act$interval),FUN=mean)
```

## What is mean total number of steps taken per day?

```r
hist(aggdate$steps,xlab="Steps",main="Steps per day")
```

![](PA1_template_files/figure-html/unnamed-chunk-1-1.png)\

```r
mean(aggdate$steps,na.rm=TRUE)
```

```
## [1] 10766.19
```

```r
median(aggdate$steps,na.rm=TRUE)
```

```
## [1] 10765
```

## What is the average daily activity pattern?

```r
agginterval<-aggregate(act$steps,list(act$interval),FUN=mean)
plot(agginterval,type="l",xlab='Interval',ylab="steps")
```

![](PA1_template_files/figure-html/unnamed-chunk-2-1.png)\

```r
agginterval[agginterval$x==max(agginterval$x),1]
```

```
## [1] 835
```


## Imputing missing values

```r
act<-read.csv("activity\\activity.csv")
sum(is.na(act))
```

```
## [1] 2304
```

```r
names(agginterval)<-c("interval","stepavg")
act<-merge(act,agginterval,by=c("interval"))
act$steps[is.na(act$steps)] <- act$stepavg[is.na(act$steps)]

aggdate2<-aggregate(act$steps,list(act$date),FUN=sum)
names(aggdate2)<-c("date","steps")
hist(aggdate2$steps,xlab="Steps",main="Steps per day")
```

![](PA1_template_files/figure-html/unnamed-chunk-3-1.png)\

```r
mean(aggdate2$steps)
```

```
## [1] 10766.19
```

```r
median(aggdate2$steps)
```

```
## [1] 10766.19
```

## Are there differences in activity patterns between weekdays and weekends?

```r
act$date <- as.Date(act$date)
weekdays1 <- c('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday')
act$weekday <- c('weekend', 'weekday')[(weekdays(act$date) %in% weekdays1)+1L]
aggweekday<-aggregate(act$steps,list(act$interval,act$weekday),FUN=mean)
names(aggweekday)<-c("interval","weekday","stepavg")
with(aggweekday[aggweekday$weekday=="weekday",],plot(interval,stepavg,type="l",col="blue",lwd=2))
with(aggweekday[aggweekday$weekday=="weekend",],lines(interval,stepavg,type="l",col = "red",lwd=2))
legend("topright", c("weekday","weekend"), lty=c(1,1), lwd=c(2.5,2.5),col=c("blue","red"))
```

![](PA1_template_files/figure-html/unnamed-chunk-4-1.png)\
