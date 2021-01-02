ConceptText <- wellPanel(
  style = "background: transparent;",

  p(strong("What is recruitment bias adjustment and why?")),

  p("- Fisheries stock assessment packages usually model variability in recruitment using a lognormal distribution. The recruitment deviation (r) is assumed to have a normal distribution, so that exp(r) is lognormally distributed."),

  p("- Most probable value of exp(r) is exp(0) = 1. However, the mean of exp(r) is exp(sigmaR^2/2), where sigmaR is the standard deviation for recruitment in log space. Thus, the arithmetic average recruitment at any stock size will be larger than the model recruitment and we need to conduct recruitment bias adjustment."),

  p("- The typical spawner-recruit model uses median-unbiased parameters (e.g. unfished spawning stock biomass, unfished recruitment, and steepness) that correspond to the geometric average recruitment: R' = R * exp(r). To conduct bias adjustment, the spawner-recruit model uses mean-unbiased parameters that correspond to the arithmetic average recruitment: R' = R * exp(r-sigmaR^2/2). Therefore, we need to convert values between median- and mean- unbiased parameters depending on the stock assessment pacakges.")

)
