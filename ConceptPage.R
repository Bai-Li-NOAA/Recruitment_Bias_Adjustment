ConceptPage <- tabPanel(

  title = h3("Concept"),
  
  withMathJax(), 

  fluidRow(
    column(
      width = 12,
      ConceptText
    )
  ),
  
  fluidRow(
    column(
      width=4,
      h3("Input Values:"),
      numericInput(inputId = "DemoMean",
                   label = "Mean of $r$:",
                   value = 0),
      numericInput(inputId = "DemoSigmaR",
                   label = "$\\sigma_{R}$ of $r$ :",
                   value = 0.75),
      numericInput(inputId = "DemoN",
                   label = "Number of data (n):",
                   value = 1000)
    ),
    
    column(
      width=8,
      h3("Output Figures:"),
      plotOutput("Demo_figure")
    )
  )
)
