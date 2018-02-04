shinyUI(
  pageWithSidebar(
    headerPanel("Clustering Fifa17 Players Attributes"),
    
    sidebarPanel(
      selectInput("clustering","Which method of clustering?",
                  choices=c("Clara","Kmeans","PAM")),
      selectInput("xvar","Choose first variable",
                  names(dane)),
      selectInput("yvar","Choose second variable",
                  names(dane),
                  selected=names(dane)[[2]]),
      selectInput("dist","Which distance",
                  choices=c("Euclidean","Manhattan")),
      numericInput("nclusters","How many clusters",4,min=1,max=10)
      
      
      
    ),
    
    
    mainPanel(
      tabsetPanel(
        tabPanel("Clusters", plotOutput("myPlot")),
        tabPanel("Boxplots", plotOutput("myPlot1")),
        tabPanel("Shiloutte",plotOutput("myPlot2"))
      )
      
    )
  )
)