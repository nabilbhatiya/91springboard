rm(list=ls())

library(data.table)
library(reshape2)

membersdata <- fread('../rawdata/membersdata.csv')

colnames(membersdata) <- c('sno','firstname','lastname','gender','age','zone','doj','doe','industry')

summary(membersdata)

sum(membersdata$sno == '')
sum(membersdata$firstname == '')
sum(membersdata$lastname == '')
sum(membersdata$gender == '')
sum(membersdata$age == '')
sum(membersdata$zone == '')
sum(membersdata$doj == '')
sum(membersdata$doe == '')
sum(membersdata$industry == '')

membersdata$doj <- as.Date(membersdata$doj, '%d-%B-%y')
membersdata$doe <- as.Date(membersdata$doe, '%d-%B-%y')

#calculating tenure is days
membersdata$tenure_days <- as.numeric(membersdata$doe - membersdata$doj)


hist(membersdata$tenure_days, breaks = 20)
#histogram - the days in tenure is right-skewed which means frequency of companies decreases with tenure in days

save(membersdata, file = '../cleaned/membersdata.bin')

# adding full name to look for duplicates since no unique identifier such as customer id/company id available
membersdata$fullname <- paste(membersdata$firstname, membersdata$lastname)

x <- membersdata$fullname[duplicated(membersdata$fullname)]
length(x)
y <- membersdata[membersdata$fullname %in% x]

# 59 duplicate names but some either have different industries or varied differences in date of exit and date of re-joining
# so considering all of them to be separate
rm(x,y)
membersdata$fullname <- NULL

#exploring
sort(table(membersdata$industry), decreasing = T)
#media and entertainment is the hottest industry by number of rent outs, followed by real estate & tourism and hospitality

#calculating half-life
#assuming half-life to be median tenure by industry/zone
#http://www.data-miners.com/resources/Customer-Insight-Article.pdf

halflife.data <- membersdata[!is.na(membersdata$tenure_days)]
halflife.data <- halflife.data[order(halflife.data$industry, halflife.data$tenure_days, decreasing = T)]

halflife.organization <- halflife.data[,{'halflife' = median(tenure_days)},]
#halflife for organization is 176 days

halflife.industry <- halflife.data[,{'halflife' = median(tenure_days)}, by = 'industry']
colnames(halflife.industry) <- c('industry','halflife_days')
halflife.industry <- halflife.industry[order(halflife.industry$halflife_days, decreasing = T)]
halflife.industry$halflife_days <- as.integer(halflife.industry$halflife_days)
write.csv(halflife.industry, file = '../output/1_halflife/halflife_industry.csv')

halflife.zone <- halflife.data[,{'halflife' = median(tenure_days)}, by = 'zone']
colnames(halflife.zone) <- c('zone','halflife_days')
halflife.zone <- halflife.zone[order(halflife.zone$halflife_days, decreasing = T)]
halflife.zone$halflife_days <- as.integer(halflife.zone$halflife_days)
write.csv(halflife.zone, file = '../output/1_halflife/halflife_zone.csv')

halflife.zone.industry <- halflife.data[,{'halflife' = median(tenure_days)}, by = c('zone', 'industry')]
colnames(halflife.zone.industry) <- c('zone', 'industry', 'halflife_days')
halflife.zone.industry <- halflife.zone.industry[order(halflife.zone.industry$halflife_days, halflife.zone.industry$zone, decreasing = T)]
halflife.zone.industry$halflife_days <- as.integer(halflife.zone.industry$halflife_days)
halflife.zone.industry <- as.data.frame.matrix(acast(halflife.zone.industry, industry~zone, sum))
write.csv(halflife.zone.industry, file = '../output/1_halflife/halflife_zone_industry.csv')
