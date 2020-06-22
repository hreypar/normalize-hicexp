#!/usr/bin/env Rscript
#
# hreyes April 2020
# normalize-hicexp-cycloess.R
#
# Read in a hicexp object and apply cyclic loess normalization to it
#
#
#################### import libraries and set options ####################
library(optparse)
suppressMessages(library(multiHiCcompare))
library(magrittr)
library(BiocParallel)
#
options(scipen = 10)
#
cores = parallel::detectCores()
register(MulticoreParam(workers = cores - 2), default = TRUE)
#
########################## read in data ###################################
option_list = list(
  make_option(opt_str = c("-i", "--input"), 
              type = "character",
              help = "Input hicexp object as an Rds file"),
  make_option(opt_str = c("-o", "--output"), 
              type = "character", 
              help = "output filepath for the normalised hicexp object")
)

opt <- parse_args(OptionParser(option_list=option_list))

if (is.null(opt$input)){
  print_help(OptionParser(option_list=option_list))
  stop("The hicexp input file is mandatory.n", call.=FALSE)
}

the.hicexp <- readRDS(file = opt$input)
#
########################## call cyclic loess ##############################
the.hicexp <- cyclic_loess(hicexp = the.hicexp, parallel = TRUE)
#
################ save normalized hicexp ################
saveRDS(the.hicexp, file = opt$output)
