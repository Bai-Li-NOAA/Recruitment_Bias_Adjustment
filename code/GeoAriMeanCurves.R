#### Geometric and Arithmetic mean curves of recruitment comparison

#### Install and load packages ####
# remotes::install_github("Bai-Li-NOAA/Age_Structured_Stock_Assessment_Model_Comparison")
# install.packages("rstudioapi") # Get location of the script
library(ASSAMC) # Use convertSRparms function to convert median-unbiased parameters to mean-unbiased parameters, or vice versa
library(rstudioapi)

#### Set working directory ####
dir <- dirname(dirname(rstudioapi::getActiveDocumentContext()$path))
setwd(dir)
getwd()

#### sim_sr function ####
#### Computes spawning stock biomass vector, geometric and arithmetic mean curves of recruitment, and observed recruits
sim_sr <- function(geomR0, geomh, phi0, sigmaR, SRmodel, n, seed=111) {

  SRparms <- convertSRparms(R0=geomR0, h=geomh, phi=phi0, sigmaR=sigmaR,
                            mean2med=FALSE, model=SRmodel)
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
              Rvec_obs=Rvec_obs))
}

#### plot_sr function ####
plot_sr <- function(recruits) {
  xlim <- range(recruits$Svec)
  ylim <- range(recruits$Rvec_arim, recruits$Rvec_geom, recruits$Rvec_obs)
  plot(recruits$Svec, recruits$Rvec_obs,
       xlab="SSB", ylab="R",
       xlim=xlim, ylim=ylim,
       col="gray", pch=19, cex=0.5)
  lines(recruits$Svec, recruits$Rvec_geom,
        col="red", lty=2)
  lines(recruits$Svec, recruits$Rvec_arim,
        col="deepskyblue3", lty=3)
  legend("topleft",
         c("Observed R", "Geometric Mean", "Arithmetic Mean"),
         pch=c(19, NA, NA),
         lty=c(NA, 2, 3),
         col=c("gray", "red", "deepskyblue3"),
         bty="n", cex=0.8)
}
#### Beverton-Holt model ####
bh_sr <- sim_sr(geomR0=1000, geomh=0.75, phi0=0.10, sigmaR=0.6,
                SRmodel=1, n=100, seed=111)

#### Ricker model ####
ricker_sr <- sim_sr(geomR0=1000, geomh=0.75, phi0=0.10, sigmaR=0.6,
                    SRmodel=2, n=100, seed=111)

#### Plot outputs ####
jpeg(file=file.path(dir, "results", "figures", "geom_arim_curves.jpg"), width=200, height=80, units="mm", res=1200)
par(mfrow=c(1,2), mar=c(4,4,1,1))
plot_sr(bh_sr)
plot_sr(ricker_sr)
dev.off()

