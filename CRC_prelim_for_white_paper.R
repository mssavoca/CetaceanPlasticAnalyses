###########################################
# Visualizing and analyzing CRC's preliminary PBDE data
###########################################

# load packages
library(dplyr)
library(ggplot2)

# set working directory
setwd("/Users/matthewsavoca/Documents/Research Data/Whale research/")

# load data
CRC_whale <- read.csv("CRC cetacean PBDE summary.csv")
CRC_whale$Collection.Date <- as.Date(CRC_whale$Collection.Date, "%m/%d/%y") #change column to date format 
CRC_whale$SumBDEs=gsub("< LOQ", NA, CRC_whale$SumBDEs) #subs out < LOQ for NA, need for changing column format to numeric
CRC_whale$SumBDEs <- as.numeric(CRC_whale$SumBDEs)
CRC_whale$SumBDEs[is.na(CRC_whale$SumBDEs)] <- 0 #turns NAs into zeros

