ConceptText <- wellPanel(
  style = "background: transparent;",
  
  withMathJax(),
  
  tags$div(HTML("<script type='text/x-mathjax-config' >
            MathJax.Hub.Config({
            tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}
            });
            </script >
            ")),

  helpText(strong('Stock-recruitment models')),
  
  helpText('- Beverton-Holt and Ricker stock-recruitment models have been widely used in fisheries population dynamics. A lognormal error is often assumed in those stock-recruitment analyses.'),
  
  helpText('Beverton-Holt fomulation: $\\overline{R}_{y+1}=\\frac{0.8R_{0}hS_{y}}{0.2R_{0}\\phi_{0}(1-h)+S_{y}(h-0.2)}$'),
  
  helpText('Ricker formulation: $\\overline{R}_{y+1}=\\frac{S_{y}}{\\phi_{0}}e^{h(1-\\frac{S_{y}}{R_{0}\\phi_{0}})}$'),
  
  helpText('where $\\overline{R}_{y}$ is expected annual recruitment in year $y+1$, $R_{0}$ is unfished recruitment, $h$ is steepness, $S_{y}$ is spawning stock biomass in year $y$, and $\\phi_{0}$ is the unfished spawners per recruit.'),
  
  helpText('$R_{y}^{*}=\\overline{R_{y}}e^{r_{y}}$'),
  
  helpText('where $R_{y}^{*}$ is modeled recruitment, $r_{y}$ is assumed to follow a normal distribution with a mean of 0 and a standard deviation of $\\sigma_{R}$. In this case, unfished spawning stock biomass $S_{0}$, $R_{0}$, and $h$ are median-unbiased and correspond to the geometric mean curve of recruitment $R_{y}^{*}$.'),
  
  helpText(strong('Recruitment bias adjustment')),
  
  helpText('- Most probable value of $e^{r}$ is $e^{0} = 1$. However, the mean of $e^{r}$ is $e^{\\sigma_{R}^2/2}$. Thus, the arithmetic mean curve of recruitment at any stock size will be larger than the model recruitment and we need to conduct recruitment bias adjustment.'),
  
  helpText('- After bias adjustment, $R_{y}^{,}=\\overline{R_{y}}e^{r_{y}-\\sigma_{R}^2/2}$. In this case, $S_{0}$, $R_{0}$, and $h$ are mean-unbiased and correspond to the arithmetic mean curve of recruitment $R_{y}^{,}$. The maximum sustainable yield (MSY) based reference points are mean-unbiased as well if they are estimated based on mean-unbiased $S_{0}$, $R_{0}$, and $h$.')

)