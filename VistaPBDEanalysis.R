#####################################################
# Analyzing and vizulaizing VISTA cetacean contaminant data
#####################################################

# load packages
library(ggplot2)
library(dplyr)
library(readxl)
library(ggsci)
library(tidyverse)

# load data
VistaPBDE <- readr::read_csv("Vista PBDE data 2019.csv", na = c("", NA, "ND"))

# summarizing data by individual and speices for all PBDE data
Ind_tot <- group_by(VistaPBDE, Species, SampleID) %>%
  summarise(sum_PBDE_ng.g=sum(Concentration/1000, na.rm=TRUE))
View(Ind_tot)

# summarizing data by individual and speices for 10 PBDE congeners that CRC also ran
Ind_tot_CRC10PBDEs <- filter(VistaPBDE, Analyte %in% c("BDE-28/33","BDE-47","BDE-49","BDE-66","BDE-85","BDE-99","BDE-100","BDE-153","BDE-128/154","BDE-183/176")) %>% 
  group_by(Species, SampleID) %>%
  summarise(sum_PBDE_ng.g=sum(Concentration/1000, na.rm=TRUE))
View(Ind_tot_CRC10PBDEs)