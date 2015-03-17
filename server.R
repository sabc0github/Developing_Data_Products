# ---------------------------
# Author: Aravind Sesetty
# Course: Developing Data Products
# Assignment: Course Project
# Date: 03/16/2015
# ---------------------------

library(shiny)
library(ggplot2)

shinyServer(function(input, output, session) {
        
        mtcars <- data.frame(name = rownames(mtcars), mtcars)        
        mtcars$vs <- factor(mtcars$vs)
        mtcars$carb <- factor(mtcars$carb)
        mtcars$gear <- factor(mtcars$gear, levels=c(3,4,5), labels=c("3gears","4gears","5gears")) 
        mtcars$am <- factor(mtcars$am, levels=c(0,1), labels=c("Automatic","Manual")) 
        mtcars$cyl <- factor(mtcars$cyl, levels=c(4,6,8), labels=c("4cyl","6cyl","8cyl")) 
        
        output$data <- renderDataTable(
                mtcars, 
                options = list(pageLength = 10)
        )
        
        output$genericplot <- renderPlot({
                input$goButton                
                isolate({
                        genplot <- ggplot(mtcars, aes_string(input$xaxis, input$yaxis, colour= input$colorby)) + layer(geom = input$plottype)
                        print(genplot)
                })
        })
        
        output$ttest <- renderText({
                x <- t.test(mpg ~ am, data=mtcars, conf.level = input$conflevel)                
                paste(capture.output(x), collapse="<br>")

        })
        
        runRegression <- reactive({
                lm(as.formula(paste(input$outcome, " ~ ", paste(input$predictors, collapse = "+"))), data = mtcars)
        })
        
        output$lmfit <- renderTable({
                if(!is.null(input$predictors)){
                        runRegression()
                } else {
                        print(data.frame(Warning="Please select Model Parameters."))
                }
        })
        
        output$currentTime <- renderText({
                invalidateLater(1000, session)
                paste("", Sys.time())
        })
})