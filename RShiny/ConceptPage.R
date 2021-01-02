ConceptPage <- tabPanel(

  title = h3("Concept"),

  fluidRow(
    column(
      width = 12,
      ConceptText
    )
  ),

  fluidRow(
    column(
      width=4,
      h3("Inputs:"),
      numericInput(inputId = "geomR0",
                   label = "geomR0:",
                   value = 1000000),
      numericInput(inputId = "geomh",
                   label = "geomh:",
                   value = 0.75,
                   min=0.21,
                   max=1),
      numericInput(inputId = "phi0",
                   label = "phi0:",
                   value = 0.01025625),
      numericInput(inputId = "sigmaR",
                   label = "sigmaR:",
                   value = 0.8),
      numericInput(inputId = "n",
                   label = "Number of data (n):",
                   value = 1000)
    ),

    column(
      width=8,
      h3("Outputs:"),
      uiOutput("GeoAriCurves_table"),
      plotOutput("GeoAriCurves_figure")
    )
  )
)
