# for shinyapps.io, each helper function file and all libraries need to be sourced
# Load required libararies
library(shiny)
library(stringr)
library(data.table)

# load the ngram model used for type ahead prediction
load("data/ngrams.RData")

#ngrams<- readRDS("data/ngrams.rds")

#load helper functions
source("helpers.R")

shinyServer(function(input, output) {
    
    # You can access the value of the widget with input$text, e.g.
                           
    output$value <- renderText({predictNext(input$text,ngrams)})
    
    output$message <- renderText({
        if (input$text < 1)
            "Start typing few words for prediction..."
        else
            "Continue typing for more predictions..."
    })
})
