library(shiny)
library(igraph)
library(ggplot2)

shinyServer(function(input, output) {
    
    graph <- reactive({ 
        if (input$graph == "barabasi") {
            barabasi.game(input$n)
        } else if (input$graph == "erdos") {
            erdos.renyi.game(input$n, 1/input$n)
        } else {
            watts.strogatz.game(1, input$n, 3, 1/input$n)
        } 
    })
    
    output$plot <- renderPlot({
        plot(graph())
    })
    
    # Generate a summary of the data
    output$path <- renderPrint({
        average.path.length(graph())
    })
     
    output$degdist <- renderPlot({
        p <- degree.distribution(graph())
        d <- 1:length(p)
        data <- data.frame(proportion=p, degree=d)
        p <- ggplot(data, aes(x=degree, y=proportion))
        p <- p + geom_point() + geom_line() + ylim(0,1.0)
        p <- p + scale_x_continuous(breaks=c(1:max(d)))
        print(p)
    })
    
})
