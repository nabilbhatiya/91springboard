rm(list=ls())

library(data.table)
library(reshape2)

load('../cleaned/membersdata.bin')

organization.avgduration <- membersdata[,{as.integer(mean(tenure_days, na.rm = T))},by='industry']
colnames(organization.avgduration) <- c('industry','avg_stay_duration')
fwrite(organization.avgduration, file = '../output/3_avgduration/organization_avg_stay_duration.csv')

zone.avgduration <- membersdata[,{as.integer(mean(tenure_days, na.rm = T))},by=c('zone', 'industry')]
colnames(zone.avgduration) <- c('zone','industry','avg_stay_duration')

zone.avgduration <- as.data.frame.matrix(acast(zone.avgduration, industry~zone, value.var = 'avg_stay_duration', sum))
write.csv(zone.avgduration, file = '../output/3_avgduration/zone_avg_stay_duration.csv')



