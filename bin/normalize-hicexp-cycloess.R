#!/usr/bin/env Rscript
#
# hreyes April 2020
# normalize-hicexp-cycloess.R
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
cores = parallel::detectCores()
register(MulticoreParam(workers = cores - 2), default = TRUE)
#
########################## read in data ###################################
args = commandArgs(trailingOnly=TRUE)
#
args[!grepl(".cycnorm", args)]  %>% 
  readRDS() -> my.hicexp
#
outcycnorm.path = args[grepl("cycnorm", args)]
#
########################## call cyclic loess ##############################
my.hicexp <- cyclic_loess(hicexp = my.hicexp, parallel = TRUE)
#
################ save normalized hicexp ################
saveRDS(my.hicexp, file = outcycnorm.path)
