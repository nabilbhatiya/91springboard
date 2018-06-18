rm(list=ls())

library(data.table)
library(zoo)

load('../cleaned/membersdata.bin')

membersdata$joinmonth <- as.yearmon(membersdata$doj)
membersdata$agebin <- cut(membersdata$age, breaks=c(16,21,26,31, 36, 41, 46, 51, 56), labels=c("16-20","21-25","26-30", "31-35", "36-40", "41-45", "46-50", "51-55"))

avg.join.month <- membersdata[,{list(.N / length(unique(joinmonth)),
                                     .N,
                                     uniqueN(joinmonth))}, by = c('zone', 'gender', 'agebin')]

colnames(avg.join.month) <- c('zone','gender','agebin', 'avg_join_per_month', 'num_joins', 'num_months')

write.csv(avg.join.month, file = '../output/5_targetprofile/avg_join_month.csv')

demographic.target.profiles <- avg.join.month[order(avg.join.month$avg_join_per_month, decreasing = T)]
demographic.target.profiles <- demographic.target.profiles[!duplicated(paste(demographic.target.profiles$zone, demographic.target.profiles$gender))]
write.csv(demographic.target.profiles, file = '../output/5_targetprofile/target_profile_zone_demographics.csv')