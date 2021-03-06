ConverterPage <- tabPanel(

  title = h3("Converter"),

  fluidRow(
    column(
      width = 12,
      wellPanel(
        style = "background: transparent;",
        p(strong("What is spawner-recruit parameters converter?")),
        p("- This is an application for converting unfished recruitment, spawning stock biomass, and steepness values that are associated with geometric mean curve of recruitment to values that are associated with arithmetic mean curve of recruitment, and vice versa.")
      )
    )
  )
)
