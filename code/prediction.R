rm(list=ls())

library(data.table)
library(zoo)
library(reshape2)

load('../cleaned/membersdata.bin')

membersdata$join_month <- as.yearmon(membersdata$doj)
membersdata$exit_month <- as.yearmon(membersdata$doe)

growthdata <- membersdata[,{.N}, by = c('join_month', 'zone')]
colnames(growthdata) <- c('join_month','zone','num_clients')
write.csv(growthdata, file = '../output/4_prediction/overall_growth_data.csv')
#growthdata <- as.data.frame.matrix(acast(growthdata, join_month~zone, value.var = 'num_clients', sum))

bengalurugrowth <- growthdata[growthdata$zone == 'Bengaluru']
bengalurugrowth$zone <- NULL
bengalurugrowth$month <- month(bengalurugrowth$join_month)
bengalurugrowth$year <- year(bengalurugrowth$join_month)
bengalurugrowth <- as.data.frame.matrix(acast(bengalurugrowth, month~year, value.var = 'num_clients', fun.aggregate = sum))
write.csv(bengalurugrowth, file = '../output/4_prediction/bengaluru_growth.csv')

delhigrowth <- growthdata[growthdata$zone == 'New Delhi']
delhigrowth$zone <- NULL
delhigrowth$month <- month(delhigrowth$join_month)
delhigrowth$year <- year(delhigrowth$join_month)
delhigrowth <- as.data.frame.matrix(acast(delhigrowth, month~year, value.var = 'num_clients', fun.aggregate = sum))
write.csv(delhigrowth, file = '../output/4_prediction/delhi_growth.csv')

mumbaigrowth <- growthdata[growthdata$zone == 'Mumbai']
mumbaigrowth$zone <- NULL
mumbaigrowth$month <- month(mumbaigrowth$join_month)
mumbaigrowth$year <- year(mumbaigrowth$join_month)
mumbaigrowth <- as.data.frame.matrix(acast(mumbaigrowth, month~year, value.var = 'num_clients', fun.aggregate = sum))
write.csv(mumbaigrowth, file = '../output/4_prediction/mumbai_growth.csv')

noidagrowth <- growthdata[growthdata$zone == 'Noida']
noidagrowth$zone <- NULL
noidagrowth$month <- month(noidagrowth$join_month)
noidagrowth$year <- year(noidagrowth$join_month)
noidagrowth <- as.data.frame.matrix(acast(noidagrowth, month~year, value.var = 'num_clients', fun.aggregate = sum))
write.csv(noidagrowth, file = '../output/4_prediction/noida_growth.csv')
