library(shiny)
library(igraph)
library(ggplot2)
library(markdown)
library(rmarkdown)

shinyServer(function(input, output) {
  
    graph <- reactive({ 
        if (input$graph == "barabasi") {
            barabasi.game(input$n, directed=FALSE)
        } else {
            erdos.renyi.game(input$n, input$p)
        }
    })
    
    output$netplot <- renderPlot({
        plot(graph())
    })
    
    # Generate a summary of the data
    output$path <- renderPrint({
      average.path.length(graph())
    })
    
    output$cluster_number <- renderPrint({
      c <- clusters(graph())
      c$no
    })
    
    output$graph_density <- renderPrint({
      graph.density(graph())
    })
    
    output$degdist <- renderPlot({
      p <- degree.distribution(graph())
      d <- 1:length(p)
      data <- data.frame(proportion=p, degree=d)
      p <- ggplot(data, aes(x=degree, y=proportion))
      p <- p + geom_point() + geom_line() + ylim(0,1.0)
      p <- p + xlab("Degree (Number of neighbours)")
      p <- p + ylab("Proportion of all Nodes")
      p <- p + scale_x_continuous(breaks=c(1:max(d)))
      print(p)
    })
    
})

