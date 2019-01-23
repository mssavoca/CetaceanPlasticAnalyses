###########################################
# Visualizing and analyzing CRC's preliminary PBDE data
###########################################

# load packages
library(dplyr)
library(ggplot2)

# set working directory
setwd("/Users/matthewsavoca/Documents/Research Data/Whale research/")

# load and format data 
CRC_whale <- read.csv("CRC cetacean PBDE summary.csv")
CRC_whale$Collection.Date <- as.Date(CRC_whale$Collection.Date, "%m/%d/%y") #change column to date format

CRC_whale$Species=gsub("gray whale", "Gray Whale", CRC_whale$Species)
CRC_whale$Species=gsub("Bryde's whale", "Bryde's Whale", CRC_whale$Species)
CRC_whale$Species <- as.factor(CRC_whale$Species)

CRC_whale$SumBDEs=gsub("< LOQ", NA, CRC_whale$SumBDEs) #subs out < LOQ for NA, need for changing column format to numeric
CRC_whale$SumBDEs <- as.numeric(CRC_whale$SumBDEs)
CRC_whale$SumBDEs[is.na(CRC_whale$SumBDEs)] <- 0 #turns NAs into zeros

# making two subsets of data, one for mysticetes and one for odontocetes
mys <- filter(CRC_whale, !Species %in% c("Bottlenose Dolphin","Long-beaked Common Dolphin","Harbor Porpoise","Risso's Dolphin"))
odon <- filter(CRC_whale, Species %in% c("Bottlenose Dolphin","Long-beaked Common Dolphin","Harbor Porpoise","Risso's Dolphin"))

# making first graphs
PBDE_mys <- ggplot(data = mys, aes(x = Species, y = SumBDEs, colour = Species)) + 
                    geom_jitter(width = 0.25) + 
                    geom_boxplot(alpha = 0.5) + 
                    ggtitle("PBDEs in California Current mysticete biopsies") + 
                    theme(plot.title = element_text(hjust = 0.5), axis.text = element_text(size = 12), 
                          axis.title.x = element_text(size = 13), axis.title.y = element_text(size = 13)) +
                    ylab(expression(Sigma~10~BDEs~(ng/g~wet~wt)))

PBDE_mys


PBDE_mys_time <- ggplot(data = mys, aes(x = Collection.Date, y = SumBDEs)) +
  geom_point(aes(colour = Species)) + geom_smooth(method = "lm", color = "black") +
  theme(plot.title = element_text(hjust = 0.5), axis.text = element_text(size = 12), 
        axis.title.x = element_text(size = 13), axis.title.y = element_text(size = 13)) +
  ggtitle("PBDEs in California Current mysticete biopsies over time") + 
  xlab("Collection Date") +
  ylab(expression(Sigma~10~BDEs~(ng/g~wet~wt)))
 
PBDE_mys_time 


PBDE_odon <- ggplot(data = odon, aes(x = Collection.Date, y = SumBDEs, colour = Species)) + 
  geom_point() +
  geom_smooth()

PBDE_odon
