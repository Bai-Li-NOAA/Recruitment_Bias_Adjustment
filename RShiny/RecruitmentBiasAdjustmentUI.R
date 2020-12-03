library(shiny)
library(shinythemes)

source("ConceptText.R")
source("ConceptPage.R")
source("ConverterPage.R")
source("ConceptGeoAriMeanCurves.R")

RecruitBiasAdjustmentUI <- shinyUI(
  {
    fluidPage(
      theme = shinytheme("cerulean"),
      titlePanel("Spawner-Recruit Parameters Converter"),
      h4("For recruitment bias adjustment"),
      navbarPage(
        title = " ",
        ConceptPage,
        ConverterPage
      )
    )
  }
)

myserver <- function(input,output,session){
  output$GeoAriCurves_table <- renderTable(
    {
      bh_sr <- sim_sr(geomR0=input$geomR0,
                      geomh=input$geomh,
                      phi0=input$phi0,
                      sigmaR=input$sigmaR,
                      SRmodel=1,
                      n=input$nyear, seed=111)
      ricker_sr <- sim_sr(geomR0=input$geomR0,
                          geomh=input$geomh,
                          phi0=input$phi0,
                          sigmaR=input$sigmaR,
                          SRmodel=2,
                          n=input$nyear, seed=111)
      matrix_data <- matrix(c(bh_sr$arimR0, ricker_sr$arimR0,
                              bh_sr$arimh, ricker_sr$arimh),
                             ncol=2,
                             byrow=FALSE)
      rownames(matrix_data) <- c("Beverton-Holt", "Ricker")
      colnames(matrix_data) <- c("arimR0", "arimh")
      matrix_data
    }, rownames = TRUE
  )
  output$GeoAriCurves_figure <- renderPlot(
    {
      bh_sr <- sim_sr(geomR0=input$geomR0,
                      geomh=input$geomh,
                      phi0=input$phi0,
                      sigmaR=input$sigmaR,
                      SRmodel=1,
                      n=input$nyear, seed=111)
      ricker_sr <- sim_sr(geomR0=input$geomR0,
                          geomh=input$geomh,
                          phi0=input$phi0,
                          sigmaR=input$sigmaR,
                          SRmodel=2,
                          n=input$nyear, seed=111)
      par(mfrow=c(1,2))
      plot_sr(data=bh_sr, legend_title="Beverton-Holt Model")
      plot_sr(data=ricker_sr, legend_title="Ricker Model")
    }
  )
}

shinyApp(
  ui = RecruitBiasAdjustmentUI,
  server = myserver
)
