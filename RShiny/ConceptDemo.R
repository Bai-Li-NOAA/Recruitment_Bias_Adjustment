
# Demo data ---------------------------------------------------------
demo_data <- function(DemoMean, DemoSigmaR, DemoN) {
  set.seed(1)
  norm_vec <- rnorm(n = DemoN, mean = DemoMean, sd = DemoSigmaR)
  norm_mean <- round(mean(norm_vec), digits = 2)
  expr <- exp(norm_vec)
  expr_mean <- round(mean(expr), digits = 2)
  exp_bias <- round(exp(DemoSigmaR^2 / 2), digits = 2)

  demo_data <- list(
    norm_vec = norm_vec,
    norm_mean = norm_mean,
    expr = expr,
    expr_mean = expr_mean,
    exp_bias = exp_bias
  )

  return(demo_data)
}


# Plot demo data ----------------------------------------------------------
plot_demo <- function(data) {
 
  hist(data$norm_vec, main="", xlab=expression(paste("Simulated ", r)))
  abline(v=data$norm_mean, lty=2, col="blue", lwd=2)
  abline(v=0, lty=3, col="red", lwd=2)
  legend("topright", 
         c("Mean r", "0"),
         col=c("blue", "red"),
         lty=c(2, 3), 
         bty="n")
  
  hist(data$expr, main="", xlab=expression(paste("Simulated ", e^r)))
  abline(v=data$expr_mean, lty=2, col="blue", lwd=2)
  abline(v=0, lty=3, col="red", lwd=2)
  abline(v=data$exp_bias, lty=4, col="green", lwd=2)
  
  legend("topright", 
         c(expression(paste("Mean ", e^r)), 
           "0", 
           expression(paste("Mean ", e^(sigma[R]^2/2)))),
         col=c("blue", "red", "green"),
         lty=c(2, 3, 4),
         bty="n")
}
