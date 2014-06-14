library(shiny)

# Define UI for network exploration 
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Network Explorer"),
    
    # Sidebar with controls 
    sidebarLayout(
        sidebarPanel(
            radioButtons("graph", "Graph type:",
                         c("Preferential Attachment" = "barabasi",
                           "Random Attachment" = "erdos",
                           "Small World" = "watts")),
            br(),
            
            sliderInput("n", 
                        "Number of nodes:", 
                        value = 25,
                        min = 5, 
                        max = 50)
        ),
        
        # Show a tabset that includes a plot, summary, and table view
        # of the generated distribution
        mainPanel(
            tabsetPanel(type = "tabs", 
                        tabPanel("Plot", plotOutput("plot")),
                        tabPanel("Path Length", verbatimTextOutput("path")),
                        tabPanel("Degree", plotOutput("degdist"))
            )
        )
    )
))
