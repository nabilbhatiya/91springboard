rm(list=ls())

library(data.table)

load('../cleaned/membersdata.bin')

zone <- membersdata[,{.N},by=c('zone', 'industry')]
colnames(zone) <- c('zone','industry','num_clients')

zone <- as.data.frame.matrix(acast(zone, industry~zone, value.var = 'num_clients', sum))
zone.avgduration <- membersdata[,{as.integer(mean(tenure_days, na.rm = T))},by=c('zone', 'industry')]
colnames(zone.avgduration) <- c('zone','industry','avg_stay_duration')
zone.avgduration <- as.data.frame.matrix(acast(zone.avgduration, industry~zone, value.var = 'avg_stay_duration', sum))

write.csv(zone, file = '../output/6_marketrecommendations/num_clients_zone.csv')
