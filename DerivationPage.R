DerivationPage <- tabPanel(

  title = h3("Derivation Notes"),

  fluidRow(
    column(
      width = 12,
      wellPanel(
        style = "background: transparent;",
        withMathJax(),
        
        helpText(strong("Beverton-Holt model")),
        helpText('[Eq. 1] $R_{0}=\\frac{0.8R_{0}hS_{0}}{0.2R_{0}\\phi_{0}(1-h)+S_{0}(h-0.2)}$'),
        helpText('where $R_{0}$, $S_{0}$, and $h$ are median-unbiased unfished recruitment, unfished spawning stock biomass, and steepness, respectively.'),
        helpText('[Eq. 2] Bias adjustment component $b=e^{\\sigma_{R}^2/2}$'),
        helpText('[Eq. 3] $R_{0b}=\\frac{b0.8R_{0}hS_{0b}}{0.2\\phi_{0}R_{0}(1-h)+(h-0.2)S_{0b}}$'),
        helpText('where $R_{0b}$ is mean-unbiased unfished recruitment and $S_{0b}$ is mean-unbiased unfished spawning stock biomass.'),
        
        helpText('[Eq. 4] $0.2\\phi_{0}R_{0}(1-h)+(h-0.2)S_{0b} = \\frac{b0.8R_{0}hS_{0b}}{R_{0b}} = b0.8R_{0}h\\phi_{0}$'),
        helpText('[Eq. 5] $0.2R_{0}(1-h)+(h-0.2)\\frac{S_{0b}}{\\phi_{0}} = b0.8R_{0}h$'),
        helpText('[Eq. 6] $(h-0.2)\\frac{S_{0b}}{\\phi_{0}} = b0.8R_{0}h-0.2R_{0}(1-h)$'),
        helpText('[Eq. 7] $S_{0b} = \\frac{b0.8R_{0}h-0.2R_{0}(1-h)\\phi_{0}}{h-0.2}$'),
        helpText('[Eq. 8] $R_{0b} = \\frac{S_{0b}}{\\phi_{0}}$'),
        helpText('[Eq. 9] $R_{new} = \\frac{b0.8R_{0}h0.2S_{0b}}{0.2\\phi_{0}R_{0}(1-h)+(h-0.2)0.2S_{0b}}$'),
        helpText('where $R_{new}$ is recruitment when the spawning stock biomass is 20% of the unfished level'),
        helpText('[Eq. 10] $h_{b} = \\frac{R_{new}}{R_{0b}}$'),
        helpText('where $h_{b}$ is mean-unbiased steepness.'),
        helpText('When converting mean-unbiased values to median-unbiased values, the bias adustment component $b$ from Eq. 2 equals $e^{-\\sigma_{R}^2/2}$. The input values of $R_{0}$ and $h$ from Eq. 7-10 need to be mean-unbiased values, and the output values of $R_{0b}$, $h_{b}$, and $S_{0b}$ are median-unbiased values.')
      )
    )
  ),
  
  fluidRow(
    column(
      width = 12,
      wellPanel(
        style = "background: transparent;",
        withMathJax(),
        helpText(strong("Ricker model with a curvature parameter")),
        helpText('[Eq. 1] $R_{0} = \\frac{S_{0}}{\\phi_{0}}e^{\\alpha(1-\\frac{S_{0}}{R_{0}\\phi_{0}})}$'),
        helpText('where $R_{0}$ and $S_{0}$ are median-unbiased unfished recruitment and unfished spawning stock biomass, respectively. $\\alpha$ is a curvature parameter (Dorn 2002).'),
        
        helpText('[Eq. 2] $h=\\frac{\\frac{0.2S_{0}}{\\phi_{0}}e^{\\alpha(1-\\frac{0.2S_{0}}{R_{0}\\phi_{0}})}}{\\frac{S_{0}}{\\phi_{0}}e^{\\alpha(1-\\frac{S_{0}}{R_{0}\\phi_{0}})}}$'),
        helpText('[Eq. 3] $h=0.2e^{\\alpha(1-\\frac{0.2S_{0}}{R_{0}\\phi_{0}})-\\alpha(1-\\frac{S_{0}}{R_{0}\\phi_{0}})}=0.2e^{\\frac{0.8S_{0}\\alpha}{R_{0}\\phi_{0}}}=0.2e^{0.8\\alpha}$'),
        helpText('[Eq. 4] $\\alpha=\\frac{log(5h)}{0.8}=1.25log(5h)$'),
        
        p(''),
        helpText(strong("Ricker model with steepness parameter")), 
        helpText('[Eq. 5] $R_{0} = \\frac{S_{0}}{\\phi_{0}}e^{h(1-\\frac{S_{0}}{R_{0}\\phi_{0}})}$'),
        helpText('where $R_{0}$, $S_{0}$, and $h$ are median-unbiased unfished recruitment, unfished spawning stock biomass, and steepness, respectively.'),
        helpText('[Eq. 6] Bias adjustment component $b=e^{\\sigma_{R}^2/2}$'),
        helpText('[Eq. 7] $R_{0b} = \\frac{bS_{0b}}{\\phi_{0}}e^{h(1-\\frac{S_{0b}}{R_{0}\\phi_{0}})}$'),
        helpText('where $R_{0b}$ is mean-unbiased unfished recruitment and $S_{0b}$ is mean-unbiased unfished spawning stock biomass.'),
        helpText('[Eq. 8] $\\frac{R_{0b}\\phi_{0}}{bS_{0b}} = e^{h(1-\\frac{S_{0b}}{R_{0}\\phi_{0}})}$'),
        helpText('[Eq. 9] $log(1/b)=h(1-\\frac{S_{0b}}{R_{0}\\phi_{0}})$'),
        helpText('[Eq. 10] $-log(b)=h-\\frac{S_{0b}h}{R_{0}\\phi_{0}})$'),
        helpText('[Eq. 11] $\\frac{S_{0b}h}{R_{0}\\phi_{0}}=h+log(b)$'),
        helpText('[Eq. 12] $S_{0b}h=R_{0}\\phi_{0}(h+log(b))$'),
        helpText('[Eq. 13] $S_{0b}=R_{0}\\phi_{0}(1+log(b)/h)$'),
        helpText('[Eq. 14] $R_{0b}=\\frac{S_{0b}}{\\phi_{0}}$'),
        helpText('[Eq. 15] $R_{new}=\\frac{b0.2S_{0b}}{phi_{0}}e^{h(1-\\frac{0.2S_{0b}}{R_{0}\\phi_{0}})}$'),
        helpText('where $R_{new}$ is recruitment when the spawning stock biomass is 20% of the unfished level'),
        helpText('[Eq. 16] $h_{b}=1.25log(5\\frac{R_{new}}{R_{0b}})$'),
        helpText('When converting mean-unbiased values to median-unbiased values, the bias adustment component $b$ from Eq. 6 equals $e^{-\\sigma_{R}^2/2}$. The input values of $R_{0}$ and $h$ from Eq. 13-16 need to be mean-unbiased values, and the output values of $R_{0b}$, $h_{b}$, and $S_{0b}$ are median-unbiased values.'),
        
        p(''),
        
        helpText(strong('References')),
        
        tags$a(href="https://afspubs.onlinelibrary.wiley.com/doi/pdf/10.1577/1548-8675(2002)022%3C0280:AOWCRH%3E2.0.CO;2", 
               "Dorn 2002: Advice on West Coast Rockfish Harvest Rates from Bayesian Meta-Analysis of Stock-Recruit Relationships")
        
      )
    )
  )
  
)

