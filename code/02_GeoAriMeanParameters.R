#### Median- and Mean-unbiased parameters comparison

#### Install and load packages ####
# remotes::install_github("Bai-Li-NOAA/Age_Structured_Stock_Assessment_Model_Comparison")
# install.packages("rstudioapi") # Get location of the script
library(ASSAMC) # Use convertSRparms function to convert median-unbiased parameters to mean-unbiased parameters, or vice versa
library(rstudioapi)

#### Set working directory ####
dir <- dirname(dirname(rstudioapi::getActiveDocumentContext()$path))
setwd(dir)
getwd()

#### calc_conversion_matrix function ####
calc_conversion_matrix <- function(geomR0, geomh_vec, sigmaR_vec, phi0){
  ## geomR0: virgin recruitment that is associated with geometric mean curve of recruitment
  ## geomh_vec: steepness that is associated with geometric mean curve of recruitment; provide a vector of steepness to be tested
  ## sigmaR_vec: standard deviation of log recruitment; provide a vector of sigmaR to be tested
  ## phi0: unfished spawning biomass per recruit

  conversion_matrix <- expand.grid(geomh_vec=geomh_vec, sigmaR_vec=sigmaR_vec)
  conversion_matrix$geomR0_vec <- rep(geomR0, nrow(conversion_matrix))
  conversion_matrix$phi0 <- rep(phi0, nrow(conversion_matrix))
  conversion_matrix$arimh_vec_BH <- conversion_matrix$arimR0_vec_BH <-
    conversion_matrix$arimh_vec_Ricker <- conversion_matrix$arimR0_vec_Ricker <-
    NA

  for (i in 1:nrow(conversion_matrix)){
    SRparms <- convertSRparms(R0=conversion_matrix$geomR0_vec[i],
                              h=conversion_matrix$geomh_vec[i],
                              phi=conversion_matrix$phi0[i],
                              sigmaR=conversion_matrix$sigmaR_vec[i],
                              mean2med=FALSE,
                              model=1)
    conversion_matrix$arimh_vec_BH[i] <- SRparms$hBC
    conversion_matrix$arimR0_vec_BH[i] <- SRparms$R0BC

    SRparms <- convertSRparms(R0=conversion_matrix$geomR0_vec[i],
                              h=conversion_matrix$geomh_vec[i],
                              phi=conversion_matrix$phi0[i],
                              sigmaR=conversion_matrix$sigmaR_vec[i],
                              mean2med=FALSE,
                              model=2)
    conversion_matrix$arimh_vec_Ricker[i] <- SRparms$hBC
    conversion_matrix$arimR0_vec_Ricker[i] <- SRparms$R0BC
  }
  return(conversion_matrix)
}

#### plot_conversion_matrix function ####
plot_conversion_matrix <- function(data){
  par(mfrow=c(1, 2), mar=c(4, 4, 0.5, 0.5))
  unique_sigmaR <- sort(unique(data$sigmaR_vec))
  unique_geomh <- sort(unique(data$geomh_vec))
  col=rainbow(n=length(unique_sigmaR))

  ## Beverton-Holt model
  plot(x=data$geomh_vec[which(data$sigmaR_vec==unique_sigmaR[1])],
       y=data$arimh_vec_BH[which(data$sigmaR_vec==unique_sigmaR[1])],
       type="l", lty=1, col=col[1],
       xlab="Median-unbiased Steepness",
       ylab="Mean-unbiased Steepness",
       xlim=c(0.2,1), ylim=c(0.2,1))
  for(i in 1:length(unique_sigmaR)){
    lines(x=data$geomh_vec[which(data$sigmaR_vec==unique_sigmaR[i])],
          y=data$arimh_vec_BH[which(data$sigmaR_vec==unique_sigmaR[i])],
          lty=i, col=col[i])
  }
  legend("bottomright",
         title="B-H Model",
         legend=paste("sigmaR =", sigmaR_vec),
         col=col,
         lty=1:length(sigmaR_vec),
         bty="n",
         cex=0.8)

  ## Ricker model
  plot(x=data$geomh_vec[which(data$sigmaR_vec==unique_sigmaR[1])],
       y=data$arimh_vec_Ricker[which(data$sigmaR_vec==unique_sigmaR[1])],
       type="l", lty=1, col=col[1],
       xlab="Median-unbiased Steepness",
       ylab="Mean-unbiased Steepness",
       xlim=c(0.2,1), ylim=c(0.2,1))
  for(i in 1:length(unique_sigmaR)){
    lines(x=data$geomh_vec[which(data$sigmaR_vec==unique_sigmaR[i])],
          y=data$arimh_vec_Ricker[which(data$sigmaR_vec==unique_sigmaR[i])],
          lty=i, col=col[i])
  }
  legend("bottomright",
         title="Ricker Model",
         legend=paste("sigmaR =", sigmaR_vec),
         col=col,
         lty=1:length(sigmaR_vec),
         bty="n",
         cex=0.8)
}

#### Conversion over a range of steepness and recruitment variations ####
geomR0 <- 1000000
phi0 <- 0.01025625
geomh_vec <- seq(0.21, 1, by=0.01) # Steepness that is associated with geometric mean curve of recruitment
sigmaR_vec <- seq(from=0.2, to=2, by=0.2)

conversion_matrix <- calc_conversion_matrix(geomR0=geomR0,
                                            geomh_vec=geomh_vec,
                                            sigmaR_vec=sigmaR_vec,
                                            phi0=phi0)

jpeg(file=file.path(dir, "results", "figures", "geom_arim_parameters.jpg"), width=200, height=100, units="mm", res=1200)
plot_conversion_matrix(conversion_matrix)
dev.off()