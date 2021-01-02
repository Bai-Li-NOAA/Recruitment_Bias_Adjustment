#### Geometric and Arithmetic mean curves of recruitment comparison

#### Install and load packages ####
remotes::install_github("Bai-Li-NOAA/Age_Structured_Stock_Assessment_Model_Comparison")
# install.packages("rstudioapi") # Get location of the script
library(ASSAMC) # Use convertSRparms function to convert median-unbiased parameters to mean-unbiased parameters, or vice versa
# library(rstudioapi)

#### Set working directory ####
# dir <- dirname(dirname(rstudioapi::getActiveDocumentContext()$path))
# setwd(dir)
# getwd()
# setwd(getwd())

#### sim_sr function ####
#### Computes spawning stock biomass vector, geometric and arithmetic mean curves of recruitment, and observed recruits
sim_sr <- function(geomR0, geomh, phi0, sigmaR, SRmodel, n, seed=111) {
  ## geomR0: virgin recruitment that is associated with geometric mean curve of recruitment
  ## geomh: steepness that is associated with geometric mean curve of recruitment
  ## phi0: unfished spawning biomass per recruit
  ## sigmaR: standard deviation of log recruitment
  ## SRmodel: spawner-recruit model
  ##          =1: Beverton-Holt model
  ##          =2: Ricker model
  ## n: number of data points (e.g. spawning stock biomass)
  ## seed: seed of R's random number generator

  SRparms <- convertSRparms(R0=geomR0, h=geomh, phi=phi0, sigmaR=sigmaR,
                            mean2med=FALSE, model=SRmodel) # Convert median-unbiased values to mean-unbiased values
  arimS0 <- SRparms$S0BC
  arimR0 <- SRparms$R0BC
  arimh <- SRparms$hBC

  geomS0 <- geomR0 * phi0
  BC <- (sigmaR^2)/2

  set.seed(seed)

  #Svec <- runif(n, min=0, max=arimS0)
  Svec=seq(0.001, arimS0, length=n)
  lnormdev.vec <- rlnorm(n, 0, sigmaR)

  if (SRmodel==1) {
    Rvec_arim <- (0.8*arimR0*arimh*Svec)/(0.2*arimR0*phi0*(1-arimh) + Svec*(arimh-0.2)) # Arithmetic mean curve
    Rvec_geom <- (0.8*geomR0*geomh*Svec)/(0.2*geomR0*phi0*(1-geomh) + Svec*(geomh-0.2)) # Geometric mean curve
  }

  if (SRmodel==2) {
    Rvec_arim <- Svec/phi0*exp(arimh*(1-Svec/(arimR0*phi0))) # Arithmetic mean curve
    Rvec_geom <- Svec/phi0*exp(geomh*(1-Svec/(geomR0*phi0))) # Geometric mean curve
  }

  Rvec_obs <- Rvec_arim * lnormdev.vec * exp(-BC)

  return(list(Svec=Svec,
              Rvec_arim=Rvec_arim,
              Rvec_geom=Rvec_geom,
              Rvec_obs=Rvec_obs,
              arimR0=arimR0,
              arimh=arimh,
              geomR0=geomR0,
              geomh=geomh))
}

#### plot_sr function ####
plot_sr <- function(data, legend_title) {
  ## data: data to be plotted (requires vector of SSB, arithmetic mean of R, geometric mean of R, and Observed R)
  ## legend_title: title of the figure (e.g. B-H Model or Ricker Model)
  xlim <- range(data$Svec)
  #ylim <- range(data$Rvec_arim, data$Rvec_geom, data$Rvec_obs)
  ylim <- range(data$Rvec_arim, data$Rvec_geom)
  plot(data$Svec, data$Rvec_obs,
            xlab="SSB", ylab="R",
            xlim=xlim, ylim=ylim,
            col="gray", pch=19, cex=0.5)
  lines(data$Svec, data$Rvec_geom,
        col="red", lty=2, lwd=2)
  lines(data$Svec, data$Rvec_arim,
        col="deepskyblue3", lty=3, lwd=2)
  legend("topleft",
         title=legend_title,
         legend=c("Observed R", "Geometric Mean", "Arithmetic Mean"),
         pch=c(19, NA, NA),
         lty=c(NA, 2, 3),
         col=c("gray", "red", "deepskyblue3"),
         bty="n", cex=0.8)
}
#### Beverton-Holt model ####
# bh_sr <- sim_sr(geomR0=1000, geomh=0.75, phi0=0.01025625, sigmaR=0.6,
#                 SRmodel=1, n=100, seed=111)

#### Ricker model ####
# ricker_sr <- sim_sr(geomR0=1000, geomh=0.75, phi0=0.01025625, sigmaR=0.6,
#                     SRmodel=2, n=100, seed=111)

# #### Plot outputs ####
# plot_sr(data=bh_sr, legend_title="B-H Model")
# bh_curve <- recordPlot()
# dev.off()
# plot_sr(data=ricker_sr, legend_title="Ricker Model")
# ricker_curve <- recordPlot()
# dev.off()


