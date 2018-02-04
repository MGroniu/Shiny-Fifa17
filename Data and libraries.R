# recommended packages for cluster analysis
# also other packages are available
if(!require(readxl)){install.packages("readxl")}
library(readxl)
if(!require(cluster)){install.packages("cluster")}
library(cluster)
if(!require(factoextra)){install.packages("factoextra")}
library(factoextra)
if(!require(flexclust)){install.packages("flexclust")}
library(flexclust)
if(!require(fpc)){install.packages("fpc")}
library(fpc)
if(!require(clustertend)){install.packages("clustertend")}
library(clustertend)
if(!require(ClusterR)){install.packages("ClusterR")}
library(ClusterR)

#Setting directory#
#Please write your directory with file below#
setwd("Write your directory here")
dane<-read_excel("FullData3000.xlsx")


