###read in all data from train and test folders
##u need features.txt, X and y tarin data, X and y test data, Subject test and train data

#X_test, X_train, subject_test, subject_train, y_test, y_train, features.txt

X_test <- read.table("~/getNcleanData/UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")
y_test <- read.table("~/getNcleanData/UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")
subject_test <- read.table("~/getNcleanData/UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")

X_train <- read.table("~/getNcleanData/UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
y_train <- read.table("~/getNcleanData/UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")
subject_train <- read.table("~/getNcleanData/UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")

features <- read.table("~/getNcleanData/UCI HAR Dataset/features.txt", quote="\"", comment.char="")


names(X_test) = features$V2; names(X_train) = features$V2
names(y_test) = "y"; names(y_train)="y"

labels=c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
yt=y_test$y;ys=rep()
for(i in 1:length(yt)){ys = c(ys, labels[yt[i]])}
y_test$y = as.factor(ys)

yt=y_train$y;ys=rep()
for(i in 1:length(yt)){ys = c(ys, labels[yt[i]])}
y_train$y = as.factor(ys)

names(subject_test) ="subject"; names(subject_train) ="subject"
##column mind y's to respective X datasets
X_test = data.frame(cbind(X_test, y_test))
X_test = data.frame(cbind(X_test, subject_test))

X_train = data.frame(cbind(X_train, y_train))
X_train = data.frame(cbind(X_train, subject_train))

##row bind X_train and X_test
combined = data.frame(rbind(X_train, X_test))
combined$subject=as.factor(combined$subject)


###pick out columns representing means and stds
ms = features$V2[grep("mean|std",features$V2)]

means_stds = combined[,ms]


###aggregate mean for each activity and subject
agg = aggregate(. ~y + subject, combined, mean)
agg = agg[order(agg$y, agg$subject),]

##data table one
write.table(combined, file="/Users/mikelakoju/getNcleanData/tidyDataCombined.txt", row.names=F)
write.table(ms, file="/Users/mikelakoju/getNcleanData/tidyDataMeand.txt", row.names=F)

write.table(agg, file="/Users/mikelakoju/getNcleanData/tidyDataSolution.txt", row.names=F)







