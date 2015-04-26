# Load packages
library(shiny)

shinyUI(fluidPage(

    titlePanel("Data Science Capstone: Word Prediction Model using NLP"),
    
    # Copy the line below to make a text input box
    
    hr(),
    # Text input box
    textInput("text", label = h4("Enter your text here to predict next word..."), value = "Good"),
    
    
    h4('Next predicted word(s): ', style = "color:blue;"),
    fluidRow(column(3, verbatimTextOutput("value")))

))
