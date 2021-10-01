ConversionText <- wellPanel(
  style = "background: transparent;",
  
  helpText(strong('Conversion')),
  
  tags$div(
    "The recruitment bias adjustment conversion issue was discovered when Li et al. (2021) worked on the comparison of four primary age-structured stock assessent models used in the United States. Special thanks to Chris Legault for developing the Beverton-Holt model conversion function and Kyle Shertzer for providing deriviation notes. The",
    
    tags$a(href="https://github.com/Bai-Li-NOAA/Age_Structured_Stock_Assessment_Model_Comparison/blob/master/R/convertSRparams.R", 
           "stock-recruit parameters conversion funtion"),
    
    "and the", 
    
    tags$a(href="https://github.com/Bai-Li-NOAA/Age_Structured_Stock_Assessment_Model_Comparison/blob/master/R/OM_MsyCalcs.R", 
           "MSY-based reference points adjustment function"),
    
    "can be found in the Age-Structured Stock Assessment Model Comparison Project ",
    tags$a(href="https://github.com/Bai-Li-NOAA/Age_Structured_Stock_Assessment_Model_Comparison", 
           "GitHub Repository."),
    
    "More papers about recruitment bias adjustment can be found under the references section. Please feel free to contact bai.li@noaa.gov if you have any questions."
  ),
  
  p(''),
  
  p('In this R Shiny App, we provide converted $R_{0}$ and $h$ values that correspond to arithmetic mean curve of recruitment in a table. We also provide two figures that show the difference between geometric and arithmetic mean curves of recruitment given a fixed set of input values.')
  
)

References <- wellPanel(
  style = "background: transparent;",
  
  helpText(strong('References')),
  
  tags$a(href="https://cdnsciencepub.com/doi/10.1139/f85-230", 
         "1) Hilborn 1985: Simplified calculation of optimum spawning stock size from Ricker's stock recruitment curve"),
  
  p(''),
  
  tags$a(href="https://doi.org/10.1577/M03-053.1", 
         "2) Chen 2011: Bias and bias correction in fish recruitment prediction"),
  
  p(''),
  
  tags$a(href="https://doi.org/10.1139/f2011-092", 
         "3) Methot and Taylor 2011: Adjusting for bias due to variability of estimated recruitments in fishery assessment models"),
  
  p(''),
  
  tags$a(href="https://doi.org/10.1093/icesjms/fsu148", 
         "4) Subbey et al. 2014: Modelling and forecasting stock-recruitment: current and future perspectives"),
  
  p(''),
  
  tags$a(href="https://doi.org/10.7755/FB.119.2-3.5", 
         "5) Li et al. 2021: A comparison of 4 primary age-structured stock assessment models used in the United States")
  
)



