library(shiny)

# Define UI for network exploration 
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Network Explorer"),
    
    # Sidebar with controls 
    sidebarLayout(
        sidebarPanel(
            h3("Select options"),
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
                             ),
            hr(),
            h3("Getting Started"),
            HTML("This is a teaching tool for the interactive exploration of 
              basic concepts in network analysis. The <strong>About tab</strong> on the right
              has more detailed description of the rationale and 
              suggested explorations that you may want to try out.")
        ),
        
        # Show a tabset that includes a plot, summary, and table view
        # of the generated distribution
        mainPanel(tabsetPanel(type = "tabs", 
                              tabPanel("Network", 
                                       verticalLayout(
                                         plotOutput("netplot"),
                                         fluidRow(
                                           column(4,
                                                  h4("Average path length"),
                                                  verbatimTextOutput("path"),
                                                  p("The average number of hops from any node to any other
                                                    node in the graph (average degrees of separation).")
                                                  ),
                                           column(4,
                                                  h4("Number of clusters"),
                                                  verbatimTextOutput("cluster_number"),
                                                  p("The number of groups of connected nodes in the graph. 
                                                    (A solitary node counts as a cluster).")
                                                  ),
                                           column(4,
                                                  h4("Graph Density"),
                                                  verbatimTextOutput("graph_density"),
                                                  p("Ratio of actual number of edges to total 
                                                    number of possible edges")
                                                  )
                                           )
                                         )
                                       ),
                              tabPanel("Degree Distribution", 
                                       verticalLayout(
                                         p("Relative distribution: the proportion of nodes having a given 
                                           number of connected neighbours."),
                                         hr(),
                                         plotOutput("degdist")
                                       )
                              ),
                              tabPanel("About",
                                       includeMarkdown("README.md"))
                              )
                  )
    )
))

