library('plyr')
library('dplyr')
# Helper functions

is.empty <- function(s) {
    s == ""
}

rm.digits <- function(s) {
    # '1 text' |-> 'text'
    sub("^[0-9]+ *", "", s)
}
features <- readLines('data/features.txt')
features <- sapply(features, rm.digits)


## Merge training and test data to a dataframe
X_train_txt <- readLines("./data/train/X_train.txt")
X_test_txt <- readLines("./data/test/X_test.txt")
X_both <- c(X_train_txt, X_test_txt)
X_both_list <-
    lapply(X_both, function(x) {
        unlist(strsplit(x, " "))
    })
# remove empty entries
X_both_list <- lapply(X_both_list, function(x) {
    x[!is.empty(x)]
})
# Convert to dataframe
## To do so we unlist the list, then fill a matrix by rows with
## the correct length, and finally make the matrix into a dataframe
df <-
    data.frame(matrix(
        unlist(X_both_list),
        nrow = length(X_both_list),
        byrow = TRUE
    ))
names(df) <- features

# Extracts only the measurements on 
# the mean and standard deviation 
# for each measurement.

df <- df[,grep("mean\\(|std\\(",names(df))]


### Convert to numeric
for (i in 1:ncol(df)){
    df[,i] <- as.numeric(df[,i])
}


# Add subject numbers
train_subjects_txt <- readLines("./data/train/subject_train.txt")
test_subjects_txt <- readLines("./data/test/subject_test.txt")
both_subjects <- c(train_subjects_txt, test_subjects_txt)
df$Subject <- both_subjects

# Add Activity
y_train_txt <- readLines("./data/train/y_train.txt")
y_test_txt <- readLines("./data/test/y_test.txt")
y_both <- c(y_train_txt, y_test_txt)
df$Activity <- y_both

# Rename activities
rename_activities <- function(x) {
    switch(
        x,
        "1" = "WALKING",
        "2" = "WALKING_UPSTAIRS",
        "3" = "WALKING_DOWNSTAIRS",
        "4" = "SITTING",
        "5" = "STANDING",
        "6" = "LAYING"
    )
}

df$Activity <- sapply(df$Activity, rename_activities)


# Create new averaged dataset
averages <- ddply(df, c("Subject", "Activity"), function(x) {
    colMeans(select(x, -c('Subject', 'Activity')))
})

# saving results as files

write.csv(df,"./tidydata/mergedData.csv")
write.csv(averages,"./tidydata/averages.csv")
writeLines(names(df),'./tidydata/update_features.txt')
    
    
    
    
    