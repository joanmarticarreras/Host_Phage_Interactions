

#JLW -2019

# Vizualising host-phage interaction database (host at the genus level)


library(dplyr)
library(igraph)

setwd("~/Host_Phage_Interactions/data/")
x <- read.delim("Network_Data_v1.tsv",sep="\t",header=T,stringsAsFactors = F)
head(x)

x <- x %>% subset(select=c(virus.tax.id,Genus)) %>% subset(Genus!="")%>% unique()
grph <- graph_from_edgelist(as.matrix(x), directed = F)
plot(grph,vertex.size=0.001,vertex.label="")

grph2 <- delete.vertices(grph, degree(grph)==0)
plot(grph2,vertex.size=0.001,vertex.label="")
V(grph2)$type <- trimws(V(grph2)$name) %in% as.character(x$virus.tax.id)
projections <- bipartite_projection(grph2)

bac <- projections[[1]]
vir <- projections[[2]]
bac2 <- delete.vertices(bac,degree(bac)==0)
vir2 <- delete.vertices(vir,degree(vir)==0)

setwd("~/Host_Phage_Interactions/images/")
pdf("hostgenus_virsharing.pdf",height=5,width=5)
plot(bac2,vertex.size=0.001)
dev.off()

plot(vir2,vertex.size=0.001,vertex.label="")

grph3 <- delete.vertices(grph, degree(grph)<2)
V(grph3)$type <- trimws(V(grph3)$name) %in% as.character(x$virus.tax.id)
projections <- bipartite_projection(grph3)
vir <- projections[[2]]
plot(vir,vertex.size=1)

x$Genus[x$virus.tax.id%in%trimws(V(vir)$name)]
y <- x[x$virus.tax.id%in%trimws(V(vir)$name),]

################ By Host Taxid



setwd("~/Host_Phage_Interactions/data/")
x <- read.delim("Network_Data_v1.tsv",sep="\t",header=T,stringsAsFactors = F)
head(x)

x <- x %>% subset(select=c(virus.tax.id,host.tax.id)) %>% subset(host.tax.id!="")
grph <- graph_from_edgelist(as.matrix(x), directed = F)
plot(grph,vertex.size=0.001,vertex.label="")

grph2 <- delete.vertices(grph, degree(grph)==0)
plot(grph2,vertex.size=0.001,vertex.label="")
V(grph2)$type <- trimws(V(grph2)$name) %in% as.character(x$virus.tax.id)
projections <- bipartite_projection(grph2)

bac <- projections[[1]]
vir <- projections[[2]]
bac2 <- delete.vertices(bac,degree(bac)==0)
vir2 <- delete.vertices(vir,degree(vir)==0)

setwd("~/Host_Phage_Interactions/images/")
pdf("hosttaxid_virsharing.pdf",height=5,width=5)
plot(bac2,vertex.size=0.001)
dev.off()





