#!/usr/bin/env Rscript
#
# hreyes April 2020
# normalize-hicexp.R
#
# Read in a hicexp object and apply cyclic loess normalization to it
#
#
#################### import libraries and set options ####################
library(multiHiCcompare)
library(magrittr)
library(BiocParallel)

#
options(scipen = 10)
#
########################## read in data ###################################
args = commandArgs(trailingOnly=TRUE)
#
#args = c("data/breast-cancer-1mb/breast-cancer-1mb.hicexp.Rds", "results/breast-cancer-1mb/breast-cancer-1mb.cycnorm.hicexp.Rds")
args[!grepl(".cycnorm", args)]  %>% 
  readRDS() -> input.hicexp
#
outcycnorm.path = args[grepl("cycnorm", args)]
#
########################## call cyclic loess ##############################
outcycnorm <- cyclic_loess(hicexp = input.hicexp, parallel = TRUE)
#
################ save normalized hicexp ################
saveRDS(outcycnorm, file = outcycnorm.path)
