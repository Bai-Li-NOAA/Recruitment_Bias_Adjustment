ConversionPage <- tabPanel(

  title = h3("Conversion"),
  
  withMathJax(), 
  
  fluidRow(
    column(
      width = 12,
      ConversionText
    )
  ),
  
  fluidRow(
    column(
      width=4,
      h3("Input Values:"),
      numericInput(inputId = "geomR0",
                   label = "Median-unbiased $R_{0}$:",
                   value = 1000000),
      numericInput(inputId = "geomh",
                   label = "Median-unbiased $h$:",
                   value = 0.75,
                   min=0.21,
                   max=1),
      numericInput(inputId = "phi0",
                   label = "$\\phi_{0}$:",
                   value = 0.01025625),
      numericInput(inputId = "sigmaR",
                   label = "$\\sigma_{R}$:",
                   value = 0.8),
      numericInput(inputId = "n",
                   label = "Number of data (n):",
                   value = 1000)
    ),

    column(
      width=8,
      h3("Converted Output Values:"),
      uiOutput("GeoAriCurves_table"),
      plotOutput("GeoAriCurves_figure")
    )
  ),
  
  fluidRow(
    column(
      width = 12,
      References
    )
  ),
)
