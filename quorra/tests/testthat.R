#!/usr/bin/env Rscript
#
# quorra-r testthat manager script
# 
# @author <bprinty@gmail.com>
# -------------------------------------------------

library(testthat)
library(devtools)
load_all('../../quorra-r')

test_check("quorra-r")
