
#### Install and load packages ####
# install.packages("remotes")
# install.packages("devtools")
# install.packages("rstudioapi") # Get location of the script
# install.packages("readxl")
# install.packages("PBSadmb")
# devtools::install_github("cmlegault/ASAPplots", build_vignettes = TRUE)
# remotes::install_github("r4ss/r4ss", ref="development")
# remotes::install_github("Bai-Li-NOAA/Age_Structured_Stock_Assessment_Model_Comparison")
# install.packages("doParallel")
# install.packages("foreach")

library(readxl)
library(PBSadmb)
library(ASAPplots)
library(r4ss)
library(ASSAMC)
library(rstudioapi)
library(parallel)
library(doParallel)
library(foreach)

#### Set working directory ####
dir <- dirname(dirname(rstudioapi::getActiveDocumentContext()$path))
setwd(dir)
getwd()

## Setup working directory, number of simulations, and seed number
maindir <- file.path(dir, "results")
em_input_filenames <- read.csv(file.path(maindir, "em_input", "em_input_filenames.csv"))

om_sim_num <- 150 # total number of iterations per case
keep_sim_num <- 100 # number of kept iterations per case
figure_number <- 10 # number of individual iteration to plot

seed_num <- 9924

#### Life-history parameters ####
year <- 1:30
ages <- 1:12   #Age structure of the popn

initial_equilibrium_F <- TRUE
median_R0 <- 1000000 #Average annual unfished recruitment (scales the popn)
median_h <- 0.75 #Steepness of the Beverton-Holt spawner-recruit relationship.
mean_R0 <- NULL
mean_h <- NULL
SRmodel <- 1 # 1=Beverton-Holt; 2=Ricker
M <- 0.2       #Age-invariant natural mortality

Linf <- 800	  #Asymptotic average length
K <- 0.18     	#Growth coefficient
a0 <- -1.36    #Theoretical age at size 0
a.lw <- 0.000000025  #Length-weight coefficient
b.lw <- 3.0     	    #Length-weight exponent
A50.mat <- 2.25      #Age at 50% maturity
slope.mat <- 3       #Slope of maturity ogive
pattern.mat <- 1     #Simple logistic maturity
female.proportion <- 0.5   #Sex ratio

#### Fleet settings ####
fleet_num <- 1

#CV of landings for OM
cv.L <- list()
cv.L$fleet1 <- 0.005

#Input CV of landings for EMs
input.cv.L <- list()
input.cv.L$fleet1 <- 0.01

#Annual sample size (nfish) of age comp samples
n.L <- list()
n.L$fleet1 <- 200

#Define fleet selectivity
sel_fleet <- list()

sel_fleet$fleet1$pattern <- 1
sel_fleet$fleet1$A50.sel1 <- 2
sel_fleet$fleet1$slope.sel1 <- 1

#### Survey settings ####
survey_num <- 1

#CV of surveys for OM
cv.survey <- list()
cv.survey$survey1 <- 0.1

#Input CV of surveys for EMs
input.cv.survey <- list()
input.cv.survey$survey1 <- 0.2

#Annual sample size (nfish) of age comp samples
n.survey <- list()
n.survey$survey1 <- 200

#Define survey selectivity
sel_survey <- list()

sel_survey$survey1$pattern <- 1
sel_survey$survey1$A50.sel1 <- 1.5
sel_survey$survey1$slope.sel1 <- 2

#### Other settings ####
logf_sd <- 0.2
f_dev_change <- FALSE
f_pattern <- 1
start_val <- 0.01
middle_val <- NULL
end_val <- 0.39
f_val <- NULL
start_year <- 1
middle_year <- NULL

logR_sd <- 0.6
r_dev_change <- TRUE

om_bias_cor <- TRUE
bias_cor_method <- "median_unbiased" #Options: "none", "median_unbiased", and "mean_unbiased"
em_bias_cor <- TRUE

#### Case 1: B-H median-unbiased model and mismatch ####
## No adhoc bias adjustment in AMAK and ASAP
## BAM input steepness = median-unbiased steepness = 0.75
## SS input steepness = median-unbiased steepness = 0.75

case1 <- save_initial_input(base_case=TRUE, case_name = "C1")
run_om(input_list=case1, show_iter_num=F)

run_em(em_names=c("AMAK", "ASAP", "BAM", "SS"),
       input_list=case1,
       em_input_filenames=em_input_filenames[1,])

generate_plot(em_names = c("AMAK", "ASAP", "BAM", "SS"),
              plot_ncol=2, plot_nrow=2,
              plot_color = c("orange", "green", "red", "deepskyblue3"),
              input_list=case1,
              adhoc_bias_cor=FALSE)

#### Case 2: B-H median-unbiased model and match ####
## Have adhoc bias adjustment in AMAK and ASAP
## BAM input steepness = median-unbiased steepness = 0.75
## SS input steepness = mean-unbiased steepness = 0.7822135

case2 <- save_initial_input(base_case=FALSE,
                            input_list=case1,
                            case_name = "C2")

run_om(input_list=case2, show_iter_num=F)

run_em(em_names=c("AMAK", "ASAP", "BAM", "SS"), input_list=case2,
       em_input_filenames=em_input_filenames[2,])

generate_plot(em_names = c("AMAK", "ASAP", "BAM", "SS"),
              plot_ncol=2, plot_nrow=2,
              plot_color = c("orange", "green", "red", "deepskyblue3"),
              input_list=case2,
              adhoc_bias_cor=TRUE)

#### Case 3: B-H mean-unbiased model and mismatch ####
## No adhoc bias adjustment in AMAK and ASAP
## BAM input steepness = mean-unbiased steepness = 0.7822135
## SS input steepness = mean-unbiased steepness = 0.7822135

case3 <- save_initial_input(base_case=FALSE,
                            input_list=case1,
                            case_name="C3",
                            bias_cor_method="mean_unbiased")

run_om(input_list=case3, show_iter_num=F)

run_em(em_names=c("AMAK", "ASAP", "BAM", "SS"), input_list=case3,
       em_input_filenames=em_input_filenames[3,])

generate_plot(em_names = c("AMAK", "ASAP", "BAM", "SS"),
              plot_ncol=2, plot_nrow=2,
              plot_color = c("orange", "green", "red", "deepskyblue3"),
              input_list=case3,
              adhoc_bias_cor=FALSE)

#### Case 4: B-H mean-unbiased model and match ####
## Have adhoc bias adjustment in AMAK and ASAP
## BAM input steepness = median-unbiased steepness = 0.75
## SS input steepness = mean-unbiased steepness = 0.7822135

case4 <- save_initial_input(base_case=FALSE,
                            input_list=case1,
                            case_name="C4",
                            bias_cor_method="mean_unbiased")

run_om(input_list=case4, show_iter_num=F)

run_em(em_names=c("AMAK", "ASAP", "BAM", "SS"), input_list=case4,
       em_input_filenames=em_input_filenames[4,])

generate_plot(em_names = c("AMAK", "ASAP", "BAM", "SS"),
              plot_ncol=2, plot_nrow=2,
              plot_color = c("orange", "green", "red", "deepskyblue3"),
              input_list=case4,
              adhoc_bias_cor=TRUE)

#### Case 5: Ricker median-unbiased model and mismatch ####
## No adhoc bias adjustment in AMAK
## BAM input steepness = median-unbiased steepness = 0.75
## SS input steepness = median-unbiased steepness = 0.75
case5 <- save_initial_input(base_case=FALSE,
                                    input_list=case1,
                                    SRmodel=2,
                                    om_sim_num=250,
                                    case_name="C5")

print(paste("AMAK h =", exp(case5$median_h)/(4+exp(case5$median_h))))

run_om(input_list=case5, show_iter_num=F)
run_em(em_names=c("AMAK", "BAM", "SS"), input_list=case5,
       em_input_filenames=em_input_filenames[5,])
generate_plot(em_names = c("AMAK", "BAM", "SS"),
              plot_ncol=3, plot_nrow=1,
              plot_color = c("orange", "red", "deepskyblue3"),
              input_list=case5)

#### Case 6: Ricker median-unbiased model and match ####
## Have adhoc bias adjustment in AMAK
## BAM input steepness = median-unbiased steepness = 0.75
## SS input steepness = median-unbiased steepness = 0.93
case6 <- save_initial_input(base_case=FALSE,
                            input_list=case1,
                            SRmodel=2,
                            om_sim_num=250,
                            case_name="C6")

run_om(input_list=case6, show_iter_num=F)

run_em(em_names=c("AMAK", "BAM", "SS"), input_list=case6,
       em_input_filenames=em_input_filenames[6,])

generate_plot(em_names = c("AMAK", "BAM", "SS"),
              plot_ncol=3, plot_nrow=1,
              plot_color = c("orange", "red", "deepskyblue3"),
              input_list=case6,
              adhoc_bias_cor=TRUE)


#### Case 7: Ricker mean-unbiased model and mismatch ####
## No adhoc bias adjustment in AMAK
## BAM input steepness = mean-unbiased steepness = 0.93
## SS input steepness = mean-unbiased steepness = 0.93
case7 <- save_initial_input(base_case=FALSE,
                            input_list=case1,
                            SRmodel=2,
                            bias_cor_method="mean_unbiased",
                            om_sim_num=250,
                            case_name="C7")


run_om(input_list=case7, show_iter_num=F)
SRBC <- convertSRparms(R0=case7$median_R0,
               h=case7$median_h,
               phi=0.1,
               sigmaR=case7$logR_sd,
               mean2med=FALSE, model=2)
print(paste("AMAK h =", exp(SRBC$hBC)/(4+exp(SRBC$hBC))))

run_em(em_names=c("AMAK", "BAM", "SS"), input_list=case7,
       em_input_filenames=em_input_filenames[7,])
generate_plot(em_names = c("AMAK", "BAM", "SS"),
              plot_ncol=3, plot_nrow=1,
              plot_color = c("orange", "red", "deepskyblue3"),
              input_list=case7)


#### Case 8: Ricker mean-unbiased model and match ####
## Have adhoc bias adjustment in AMAK
## BAM input steepness = mean-unbiased steepness = 0.75
## SS input steepness = mean-unbiased steepness = 0.93
case8 <- save_initial_input(base_case=FALSE,
                            input_list=case1,
                            SRmodel=2,
                            bias_cor_method="mean_unbiased",
                            om_sim_num=250,
                            case_name="C8")


run_om(input_list=case8, show_iter_num=F)
print(paste("AMAK h =", exp(case8$median_h)/(4+exp(case8$median_h))))

run_em(em_names=c("AMAK", "BAM", "SS"), input_list=case8,
       em_input_filenames=em_input_filenames[8,])
generate_plot(em_names = c("AMAK", "BAM", "SS"),
              plot_ncol=3, plot_nrow=1,
              plot_color = c("orange", "red", "deepskyblue3"),
              input_list=case8,
              adhoc_bias_cor=TRUE)


#### Additional Case (AMAK_No initial F) ####
print(paste("AMAK h =", exp(base_case_input$median_h)/(4+exp(base_case_input$median_h))))
updated_input <- save_initial_input(base_case=FALSE,
                                    input_list=case1,
                                    case_name="C0_AMAK_noF",
                                    initial_equilibrium_F=FALSE)
run_om(input_list=updated_input , show_iter_num=F)
run_em(em_names=c("AMAK", "BAM", "SS"), input_list=updated_input)
generate_plot(em_names = c("AMAK", "BAM", "SS"),
              plot_ncol=3, plot_nrow=1,
              plot_color = c("orange", "red", "deepskyblue3"),
              input_list=updated_input)

