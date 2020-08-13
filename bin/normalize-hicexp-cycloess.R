#!/usr/bin/env Rscript
#
# hreyes April 2020
# normalize-hicexp-cycloess.R
#
# Read in a hicexp object and apply cyclic loess normalization to it
#
#
#################### import libraries and set options ####################
suppressMessages(library(optparse))
suppressMessages(library(multiHiCcompare))
suppressMessages(library(magrittr))
suppressMessages(library(BiocParallel))
message("\nRequired libraries have been loaded.")
#
options(scipen = 10)
#
cores = parallel::detectCores()
message(paste(cores, "cores have been detected. Using", cores-2))
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
message("The input hicexp has been loaded.")
#
########################## call cyclic loess ##############################
the.hicexp <- cyclic_loess(hicexp = the.hicexp, parallel = TRUE)
message("The hicexp has been normalised.")
#
################ save normalized hicexp ################
saveRDS(the.hicexp, file = opt$output)
message("The normalised hicexp has been saved as an Rds file.\n")

