install.packages("dplyr")
getwd()

fileEncoding = "UCS-2LE"

df.bus <- read.csv(file = "C:/Users/tntmd/AppData/Roaming/SPB_Data/exam/df.bus.csv", header = T)
df.bus

library(dplyr)
bus_top5 <- df.bus %>% group_by(노선번호) %>% summarise(승차총수=sum(총승차승객수), 
                                                       하차총수=sum(총하차승객수))%>% arrange(desc(승차총수)) %>% slice(1:5)

head(bus_top5)

graph <- bus_top5 %>% select(2:3)
graph
graph <- t(graph)
graph


b_plot <- barplot(graph/1000, beside=T, main="서울 버스 이용승객 Top5(21년 5월)", 
                  col = c("purple","yellow"), ylab="승객수(천명)", xlab="노선명(번)", 
                  ylim=c(0,50), names.arg = bus_top5$노선번호)

text(x=b_plot, y=graph/1000-5, labels=graph, col="black", cex=0.8)

grid()

legend(13, 50, c("승차인원수", "하차인원수"), col=c("purple", "yellow"), bg="white", lty=1, lwd=2)
