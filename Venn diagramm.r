setwd("/Users/mdumar/Desktop/ZZZZZZZZZZZZ_GBK_FUNGUS/ARTEMIS/Velvet_95_Assembly_cazyme_gff")
library(tidyverse)
library(stringr)
library(VennDiagram)
Cazy<-read.delim("Velvet_95_Assembly_cazy.txt") #import file from directory
Cazy<-Cazy%>% lapply(str_replace,"\\(.*", "")#remove everything after bracket 
Cazy<-Cazy%>% lapply(str_replace,"\\_.*", "")
Cazy<-Cazy%>% lapply(str_replace,"\\+.*", "")
Cazy<-data.frame(Cazy)
#Cazy[Cazy == "-"] <- ""#remove - in text file with empty space
#or
Cazy[Cazy == "-"] <- "NA" 
#write.csv(Cazy,"Cazy_ven.csv",row.names=FALSE)#in case to write
Cazy1<-data.frame(Cazy[,c(1,3,4,5)]) #subset the file
length(Cazy1) #indicate four row

#count total rows in data frame

nrow(Cazy1[!is.na(Cazy1$HMMER),])#specific column
#Area1=384
nrow(Cazy1[!is.na(Cazy1$eCAMI),])
#Area2=336
nrow(Cazy1[!is.na(Cazy1$DIAMOND),])
#Area3=718
#nrow(na.omit(Cazy1))
#Area123=281
nrow(na.omit(Cazy1[,c(2,3)]))
#Area12=384
nrow(na.omit(Cazy1[,c(3,4)]))
#Area23=302
nrow(na.omit(Cazy1[,c(2,4)]))
#Area13=333
grid.newpage() 
pv<-draw.triple.venn(area1=384, 
                     area2=336,
                     area3=718,
                     n12=289, 
                     n23=302, 
                     n13=333, n123=281, 
                     category=c("HMMER","eCAMI","DIAMOND"),
                     #col="Red",
                     fill = c("light pink", "ligh tblue", "wheat"),
                     cex = 2,
                     cat.cex = 1.5,
                     cat.fontface = "bold",
                     res=1000,
                     lwd = 1)
grid.newpage()
grid.arrange(pv, bottom=textGrob("Figure 2", gp=gpar(fontsize=15,font=8))) 
ggsave("ggplot3save.png", plot=pv, width=20, height= 16, units = c("cm"), dpi =300)
dev.off()
                 
                 
