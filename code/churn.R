##Should ideally write a function but time constrains

rm(list=ls())

library(data.table)
library(zoo)
library(reshape2)

load('../cleaned/membersdata.bin')

churndata <- as.data.frame(table(membersdata$tenure_days))
colnames(churndata) <- c('numdays','churned_companies')

x <- 4014

for (i in 1:nrow(churndata)){
  x <- x - churndata$churned_companies[i]
  churndata$remaining_companies[i] <- x
}

churndata$retention <- churndata$remaining_companies / 4014
churndata$churn_rate <- 1 - churndata$retention

churn.trend.6months <- churndata[as.numeric(churndata$numdays) < 184, ]
churn.trend.12months <- churndata[as.numeric(churndata$numdays) < 367, ]

fwrite(churn.trend.6months, file = '../output/2_churntrend/organization_churn_trend_6months.csv')
fwrite(churn.trend.12months, file = '../output/2_churntrend/organization_churn_trend_12months.csv')
fwrite(churndata, file = '../output/2_churntrend/organization_churn_data.csv')


bengaluruchurndata <- membersdata[membersdata$zone == 'Bengaluru']
#total 211
mumbaichurndata <- membersdata[membersdata$zone == 'Mumbai']
#total 520
delhichurndata <- membersdata[membersdata$zone == 'New Delhi']
#total 2159
noidachurndata <- membersdata[membersdata$zone == 'Noida']
#Total 1124


##Bengaluru 
bengaluruchurndata <- as.data.frame(table(bengaluruchurndata$tenure_days))
colnames(bengaluruchurndata) <- c('numdays','churned_companies')

x <- 211

for (i in 1:nrow(bengaluruchurndata)){
  x <- x - bengaluruchurndata$churned_companies[i]
  bengaluruchurndata$remaining_companies[i] <- x
}

bengaluruchurndata$retention <- bengaluruchurndata$remaining_companies / 211
bengaluruchurndata$churn_rate <- 1 - bengaluruchurndata$retention

churn.trend.6months <- bengaluruchurndata[as.numeric(bengaluruchurndata$numdays) < 184, ]
churn.trend.12months <- bengaluruchurndata[as.numeric(bengaluruchurndata$numdays) < 367, ]

fwrite(churn.trend.6months, file = '../output/2_churntrend/bengaluru_churn_trend_6months.csv')
fwrite(churn.trend.12months, file = '../output/2_churntrend/bengaluru_churn_trend_12months.csv')
fwrite(bengaluruchurndata, file = '../output/2_churntrend/bengaluru_churn_data.csv')


##Mumbai
mumbaichurndata <- as.data.frame(table(mumbaichurndata$tenure_days))
colnames(mumbaichurndata) <- c('numdays','churned_companies')

x <- 520

for (i in 1:nrow(mumbaichurndata)){
  x <- x - mumbaichurndata$churned_companies[i]
  mumbaichurndata$remaining_companies[i] <- x
}

mumbaichurndata$retention <- mumbaichurndata$remaining_companies / 520
mumbaichurndata$churn_rate <- 1 - mumbaichurndata$retention

churn.trend.6months <- mumbaichurndata[as.numeric(mumbaichurndata$numdays) < 184, ]
churn.trend.12months <- mumbaichurndata[as.numeric(mumbaichurndata$numdays) < 367, ]

fwrite(churn.trend.6months, file = '../output/2_churntrend/mumbai_churn_trend_6months.csv')
fwrite(churn.trend.12months, file = '../output/2_churntrend/mumbai_churn_trend_12months.csv')
fwrite(mumbaichurndata, file = '../output/2_churntrend/mumbai_churn_data.csv')

##Delhi
delhichurndata <- as.data.frame(table(delhichurndata$tenure_days))
colnames(delhichurndata) <- c('numdays','churned_companies')

x <- 2159

for (i in 1:nrow(delhichurndata)){
  x <- x - delhichurndata$churned_companies[i]
  delhichurndata$remaining_companies[i] <- x
}

delhichurndata$retention <- delhichurndata$remaining_companies / 2159
delhichurndata$churn_rate <- 1 - delhichurndata$retention

churn.trend.6months <- delhichurndata[as.numeric(delhichurndata$numdays) < 184, ]
churn.trend.12months <- delhichurndata[as.numeric(delhichurndata$numdays) < 367, ]

fwrite(churn.trend.6months, file = '../output/2_churntrend/delhi_churn_trend_6months.csv')
fwrite(churn.trend.12months, file = '../output/2_churntrend/delhi_churn_trend_12months.csv')
fwrite(delhichurndata, file = '../output/2_churntrend/delhi_churn_data.csv')

##Noida
noidachurndata <- as.data.frame(table(noidachurndata$tenure_days))
colnames(noidachurndata) <- c('numdays','churned_companies')

x <- 1124

for (i in 1:nrow(noidachurndata)){
  x <- x - noidachurndata$churned_companies[i]
  noidachurndata$remaining_companies[i] <- x
}

noidachurndata$retention <- noidachurndata$remaining_companies / 1124
noidachurndata$churn_rate <- 1 - noidachurndata$retention

churn.trend.6months <- noidachurndata[as.numeric(noidachurndata$numdays) < 184, ]
churn.trend.12months <- noidachurndata[as.numeric(noidachurndata$numdays) < 367, ]

fwrite(churn.trend.6months, file = '../output/2_churntrend/noida_churn_trend_6months.csv')
fwrite(churn.trend.12months, file = '../output/2_churntrend/noida_churn_trend_12months.csv')
fwrite(noidachurndata, file = '../output/2_churntrend/noida_churn_data.csv')