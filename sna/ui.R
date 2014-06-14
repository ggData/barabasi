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
                           "Random Attachment" = "erdos")
                         ),
            br(),
            sliderInput("n", 
                        "Number of nodes:", 
                        value = 25,
                        min = 5, 
                        max = 100),
            br(),
            conditionalPanel("input.graph == 'erdos'",
                             sliderInput("p", 
                                         "Probability of attachment:", 
                                         value = 0.1,
                                         min = 0, 
                                         max = 0.3)
                             )
        ),
        
        # Show a tabset that includes a plot, summary, and table view
        # of the generated distribution
        mainPanel(tabsetPanel(type = "tabs", 
                              tabPanel("Network", 
                                       verticalLayout(
                                         plotOutput("netplot"),
                                         h4("Average path length"),
                                         p("The average number of hops from any node to any other 
                                           node in the graph."),
                                         verbatimTextOutput("path"),
                                         h4("Number of clusters"),
                                         p("The number of groups of connected nodes in the graph. 
                                           (A solitary node counts as a cluster)."),
                                         verbatimTextOutput("cluster_number"),
                                         h4("Graph Density"),
                                         p("Ratio of actual number of edges to total 
                                           number of possible edges"),
                                         verbatimTextOutput("graph_density")
                                       )),
                              tabPanel("Degree Distribution", 
                                       verticalLayout(
                                         p("Relative distribution: the proportion of nodes having a given 
                                           number of connected neighbours."),
                                         hr(),
                                         plotOutput("degdist")
                                       )
                              )
                              )
                  )
    )
))

