library(shiny)

source("ConceptDetails.R")
source("ConceptPage.R")

source("ConversionDetails.R")
source("ConversionPage.R")

source("DerivationPage.R")

source("ConceptDemo.R")
source("convertSRparams.R")
source("GeoAriMeanCurves.R")

RecruitBiasAdjustmentUI <- shinyUI(
  {
    fluidPage(
      theme = "nmfs-styles.css",
      
      titlePanel("Recruitment Bias Adjustment"),

      navbarPage(
        title = " ",
        ConceptPage,
        ConversionPage,
        DerivationPage
      )
    )
  }
)

RecruitBiasAdjustmentServer <- function(input,output,session){
  output$Demo_figure <- renderPlot(
    {
      demo_output <- demo_data(DemoMean=input$DemoMean, 
                               DemoSigmaR=input$DemoSigmaR, 
                               DemoN=input$DemoN)
      par(mfrow=c(1,2))
      plot_demo(data=demo_output)
    }
  )
  
  output$GeoAriCurves_table <- renderTable(
    {
      bh_sr <- sim_sr(geomR0=input$geomR0,
                      geomh=input$geomh,
                      phi0=input$phi0,
                      sigmaR=input$sigmaR,
                      SRmodel=1,
                      n=input$n, seed=111)
      ricker_sr <- sim_sr(geomR0=input$geomR0,
                          geomh=input$geomh,
                          phi0=input$phi0,
                          sigmaR=input$sigmaR,
                          SRmodel=2,
                          n=input$n, seed=123)
      matrix_data <- matrix(c(bh_sr$arimR0, ricker_sr$arimR0,
                              bh_sr$arimh, ricker_sr$arimh),
                            ncol=2,
                            byrow=TRUE)
      colnames(matrix_data) <- c("Beverton-Holt", "Ricker")
      matrix_data <- data.frame(matrix_data, 
                                row.names = c("Mean-unbiased R<sub>0<sub>", "Mean-unbiased h"))
    }, rownames = TRUE, sanitize.text.function = function(x) x
  )
  
  output$GeoAriCurves_figure <- renderPlot(
    {
      bh_sr <- sim_sr(geomR0=input$geomR0,
                      geomh=input$geomh,
                      phi0=input$phi0,
                      sigmaR=input$sigmaR,
                      SRmodel=1,
                      n=input$n, seed=111)
      ricker_sr <- sim_sr(geomR0=input$geomR0,
                          geomh=input$geomh,
                          phi0=input$phi0,
                          sigmaR=input$sigmaR,
                          SRmodel=2,
                          n=input$n, seed=123)
      par(mfrow=c(1,2))
      plot_sr(data=bh_sr, legend_title="Beverton-Holt Model")
      plot_sr(data=ricker_sr, legend_title="Ricker Model")
    }
  )
}

shinyApp(
  ui = RecruitBiasAdjustmentUI,
  server = RecruitBiasAdjustmentServer
)
