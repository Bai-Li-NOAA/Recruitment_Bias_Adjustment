library(rstudioapi)
library(ggplot2)

dir <- dirname(dirname(rstudioapi::getActiveDocumentContext()$path))
setwd(dir)
getwd()

#### Plot relative error in  MSY, FMSY, SSBMSY ####
case_num <- 1:4
em_name <- c("AMAK", "ASAP", "BAM", "SS")
case_info <- rep(c(":\nOriginal", ":\nAd Hoc"), times=length(case_num)/2)
bc_info <- rep(c("Median-unbiased OM", "Mean-unbiased OM"), each=length(case_num)/2)
sr_name <- "B-H"
bh_data <- msy_re_data(dir=dir,
                       case_num=case_num,
                       em_name=em_name,
                       case_info=case_info,
                       bc_info=bc_info,
                       sr_name=sr_name)

case_num <- 5:8
em_name <- c("AMAK", "BAM", "SS")
case_info <- rep(c(":\nOriginal", ":\nAd Hoc"), times=length(case_num)/2)
bc_info <- rep(c("Median-unbiased OM", "Mean-unbiased OM"), each=length(case_num)/2)
sr_name <- "Ricker"
ricker_data <- msy_re_data(dir=dir,
                           case_num=case_num,
                           em_name=em_name,
                           case_info=case_info,
                           bc_info=bc_info,
                           sr_name=sr_name)


plot_data <- lapply(seq_along(bh_data), function(x) rbind(bh_data[[x]], ricker_data[[x]]))
ylab <- paste("RE_in_", c("MSY", "FMSY", "SSBMSY"), sep="")
for (i in 1:length(plot_data)){
  jpeg(file=file.path(dir, "results", "figures", paste(ylab[i], ".jpg", sep="")), width=200, height=100, units="mm", res=1200)
  p <- ggplot(data=plot_data[[i]], aes(x=EM, y=Median, color=EM)) +
    labs(x="", y=ylab[i]) +
    geom_hline(aes(yintercept=0), colour="gray20", lty=2) +
    geom_pointrange(aes(ymin=Lower, ymax=Upper)) +
    facet_grid(cols=vars(Case_f), rows=vars(SR)) +
    theme(legend.position = 'none')
  print(p+scale_color_manual(values = c("orange", "green", "red", "deepskyblue3")))
  dev.off()
}

#### Plot SSB, R, and F over time ####
output_file <- c("om_output.RData",
                 "amak_output.RData",
                 "asap_output.RData",
                 "bam_output.RData",
                 "ss_output.RData")
model_name <- c("OM", "AMAK", "ASAP", "BAM", "SS")
case_num <- 1:4
year <- 1:30
bc_info <- rep(c("Median-unbiased OM", "Mean-unbiased OM"), each=length(case_num)/2)
case_info <- rep(c("Original", "Ad Hoc"), times=length(case_num)/2)
sr_name <- "B-H"

bh_data <- SSB_R_F_data(dir=dir,
                       case_num=case_num,
                       model_name=model_name,
                       case_info=case_info,
                       bc_info=bc_info,
                       sr_name=sr_name,
                       output_file=output_file,
                       year=year)

output_file <- c("om_output.RData",
                 "amak_output.RData",
                 "bam_output.RData",
                 "ss_output.RData")

model_name <- c("OM", "AMAK", "BAM", "SS")
case_num <- 5:8
year <- 1:30
bc_info <- rep(c("Median-unbiased OM", "Mean-unbiased OM"), each=length(case_num)/2)
case_info <- rep(c("Original", "Ad Hoc"), times=length(case_num)/2)
sr_name <- "Ricker"

ricker_data <- SSB_R_F_data(dir=dir,
                            case_num=case_num,
                            model_name=model_name,
                            case_info=case_info,
                            bc_info=bc_info,
                            sr_name=sr_name,
                            output_file=output_file,
                            year=year)

plot_data <- rbind(bh_data, ricker_data)

jpeg(file=file.path(dir, "results", "figures", paste("ssb_r_f.jpg", sep="")), width=200, height=200, units="mm", res=1200)
p <- ggplot(data=plot_data, aes(x=year, y=value, color=model_name_f)) +
  labs(x="Year", y="") +
  geom_line(aes(linetype=model_name_f)) +
  facet_grid(cols=vars(omparam_f, case_info_f), rows=vars(sr_name_f, variable_f), scales = "free") +
  theme(legend.title = element_blank())
print(p+scale_color_manual(values = c("gray30", "orange", "green", "red", "deepskyblue3")))
dev.off()

